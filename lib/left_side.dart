import 'package:flutter/material.dart';
import 'left side/status_module.dart';
import 'left side/clock_module.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        StatusModule(),
        SizedBox(width: 10),
        ClockModule(),
      ],
    );
  }
}
