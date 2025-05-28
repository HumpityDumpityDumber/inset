import 'package:flutter/material.dart';
import 'right side/volume_module.dart';
import 'right side/power_module.dart';

class RightSide extends StatelessWidget {
  const RightSide({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        VolumeModule(),
        SizedBox(width: 10),
        PowerModule(),
      ],
    );
  }
}
