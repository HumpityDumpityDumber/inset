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

  // Get monitors and pick the first one as main monitor if available
  final monitors = await shell.getMonitorList();
  await shell.setMonitor(monitors[0]);
  
  if (isMainWindow) {
    await shell.setMonitor(monitors[1]);
  }

  await shell.setLayer(ShellLayer.layerBottom);

  for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
    await shell.setAnchor(edge, true);
  }

  await shell.setExclusiveZone(49);

  for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
    await shell.setMargin(edge, 10);
  }

  await shell.setMargin(ShellEdge.edgeTop, 0);

  await shell.initialize(0, 49);

  if (isMainWindow) {
    final window = await DesktopMultiWindow.createWindow(jsonEncode({
      'args1': 'Sub window',
      'args2': 100,
      'args3': true,
      'business': 'business_test',
    }));
    window
    ..center()
    ..setTitle('second bar');
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
