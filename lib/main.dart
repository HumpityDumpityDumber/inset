import 'package:flutter/material.dart';
import 'package:wayland_layer_shell/wayland_layer_shell.dart';
import 'package:wayland_layer_shell/types.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

import 'package:inset_shell/left_side.dart';
import 'package:inset_shell/right_side.dart';
import 'package:inset_shell/middle.dart';
import 'dart:convert';

Future<void> main([List<String>? args]) async {
  WidgetsFlutterBinding.ensureInitialized();

  final isMainWindow = args == null || args.isEmpty;

  final shell = WaylandLayerShell();

  if (!await shell.initialize(0, 0)) {
    runApp(const Center(child: Text('Wayland layer-shell not supported')));
    return;
  }

  // Parse monitor argument if present
  int assignedMonitor = 0; // default to 1 for main window
  if (!isMainWindow && args.isNotEmpty) {
    try {
      // args[0] is usually 'multi_window', args[2] is the json string
      final argJson = args.length > 2 ? args[2] : args[0];
      final Map<String, dynamic> parsedArgs = jsonDecode(argJson);
      if (parsedArgs.containsKey('monitor')) {
        // Try to parse monitor index from the string
        final monitorStr = parsedArgs['monitor'];
        assignedMonitor = int.tryParse(monitorStr) ?? 0;
      }
    } catch (_) {
      assignedMonitor = 0;
    }
  }

  final monitors = await shell.getMonitorList();
  await shell.setMonitor(monitors[assignedMonitor]);

  await shell.setLayer(ShellLayer.layerBottom);

// Set anchor and margin for bottom, left, and right edges
for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
  await shell.setAnchor(edge, true);
  await shell.setMargin(edge, 10);
}

await shell.setMargin(ShellEdge.edgeTop, 0);

// Set exclusive zone and initialize
await shell.setExclusiveZone(49);
await shell.initialize(0, 49);


  if (isMainWindow) {
    for (int i = 1; i < monitors.length; i++) {
      final window = await DesktopMultiWindow.createWindow(jsonEncode({
        'monitor': '$i',
      }));
      window;
    }
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: LeftSide(),
            ),
            Align(
              alignment: Alignment.center,
              child: Middle(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RightSide(),
            ),
          ],
        ),
      ),
    ),
  );
}
