import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../theme.dart';

class VolumeModule extends StatelessWidget {
  const VolumeModule({super.key});

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
        width: 276,
        height: 49,
        decoration: BoxDecoration(
          color: moduleBackgroundColor,
          borderRadius: BorderRadius.circular(24.5),
        ),
      ),
    );
  }
}