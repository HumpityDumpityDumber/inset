import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import '../theme.dart';

class AudioModule extends StatelessWidget {
  const AudioModule({super.key});

  @override
  Widget build(BuildContext context) {
    return InnerShadowContainer(
      width: 410,
      height: 49,
      borderRadius: 24.5,
      backgroundColor: moduleBackgroundColor,
      blur: moduleShadowBlur.toDouble(),
      offset: moduleShadowOffset,
      shadowColor: Colors.black.withAlpha(moduleShadowAlpha),
      isShadowTopLeft: true,
      isShadowTopRight: true,
      isShadowBottomLeft: true,
      isShadowBottomRight: true,
      child: const SizedBox(), // Replace with actual content if needed
    );
  }
}
