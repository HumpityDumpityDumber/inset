import 'package:flutter/material.dart';
import 'package:wayland_layer_shell/wayland_layer_shell.dart';
import 'package:wayland_layer_shell/types.dart';

import 'package:inset_shell/left_side.dart';
import 'package:inset_shell/right_side.dart';
import 'package:inset_shell/middle.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final shell = WaylandLayerShell();

  if (!await shell.initialize(0, 0)) {
    runApp(const Center(child: Text('Wayland layer-shell not supported')));
    return;
  }

  // Get monitors and pick the first one as main monitor if available
final monitors = await shell.getMonitorList();

if (monitors.isNotEmpty) {
  // Pick the first monitor for now (index 0)
  await shell.setMonitor(monitors[0]);
}


  await shell.setLayer(ShellLayer.layerTop);

  for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
    await shell.setAnchor(edge, true);
  }

  await shell.setExclusiveZone(49);

  for (final edge in [ShellEdge.edgeBottom, ShellEdge.edgeLeft, ShellEdge.edgeRight]) {
    await shell.setMargin(edge, 10);
  }

  await shell.setMargin(ShellEdge.edgeTop, 0);

  await shell.initialize(0, 49);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Make Scaffold background transparent
        // You can also adjust canvasColor, backgroundColor here if needed
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            LeftSide(),
            Middle(),   // <-- Add this line for your center widget
            RightSide(),
          ],
        ),
      ),
    ),
  );

}
