import 'package:flutter/material.dart';
import 'middle/audio_module.dart';

class Middle extends StatelessWidget {
  const Middle({super.key});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AudioModule(),
        ],
      ),
    );
  }
}
