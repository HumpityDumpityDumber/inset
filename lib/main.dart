import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayland_layer_shell/wayland_layer_shell.dart';
import 'package:wayland_layer_shell/types.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

import 'package:inset_shell/left_side.dart';
import 'package:inset_shell/right_side.dart';
import 'package:inset_shell/middle.dart';

Future<void> main([List<String>? args]) async {
  WidgetsFlutterBinding.ensureInitialized();

  final isMainWindow = args == null || args.isEmpty;

  if (isMainWindow) {
    final shell = WaylandLayerShell();

    List<String> knownMonitorNames = [];

    while (true) {
      final currentMonitors = await shell.getMonitorList();
      final currentNames = currentMonitors.map((m) => m.name).toList();

      // Find new monitors not in known list
      for (int i = 0; i < currentMonitors.length; i++) {
        if (!knownMonitorNames.contains(currentNames[i])) {
          await DesktopMultiWindow.createWindow(jsonEncode({'monitor': '$i'}));
        }
      }

      // Update known list every time after polling
      knownMonitorNames = currentNames;

      // Wait before polling again
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  // Secondary window logic
  final shell = WaylandLayerShell();

  if (!await shell.initialize(0, 0)) {
    runApp(const Center(child: Text('Wayland layer-shell not supported')));
    return;
  }

  int assignedMonitor = 0;
  if (args != null && args.isNotEmpty) {
    try {
      final argJson = args.length > 2 ? args[2] : args[0];
      final Map<String, dynamic> parsedArgs = jsonDecode(argJson);
      if (parsedArgs.containsKey('monitor')) {
        assignedMonitor = int.tryParse(parsedArgs['monitor'].toString()) ?? 0;
      }
    } catch (_) {
      assignedMonitor = 0;
    }
  }

  final monitors = await shell.getMonitorList();
  if (assignedMonitor >= monitors.length) assignedMonitor = 0;

  await shell.setMonitor(monitors[assignedMonitor]);
  await shell.setLayer(ShellLayer.layerBottom);

  for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
    await shell.setAnchor(edge, true);
    await shell.setMargin(edge, 10);
  }
  await shell.setMargin(ShellEdge.edgeTop, 0);

  await shell.setExclusiveZone(49);
  await shell.initialize(0, 49);

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
