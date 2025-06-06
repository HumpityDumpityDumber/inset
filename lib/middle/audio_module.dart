import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../theme.dart';

class AudioModule extends StatelessWidget {
  const AudioModule({super.key});

  @override
  Widget build(BuildContext context) {
    return InnerShadow(
      shadows: [
        BoxShadow(
          color: Colors.black.withAlpha(moduleShadowAlpha),
          blurRadius: moduleShadowBlur,
          offset: moduleShadowOffset,
        ),
      ],
      child: Container(
        width: 410,
        height: 49,
        decoration: BoxDecoration(
          color: moduleBackgroundColor,
          borderRadius: BorderRadius.circular(24.5),
        ),
      ),
    );
  }
}