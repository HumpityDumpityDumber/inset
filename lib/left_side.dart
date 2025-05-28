import 'package:flutter/material.dart';
import 'status_module.dart';
import 'clock_module.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: const [
          StatusModule(),
          SizedBox(width: 10),
          ClockModule(),
          // Add other widgets here
        ],
      ),
    );
  }
}
