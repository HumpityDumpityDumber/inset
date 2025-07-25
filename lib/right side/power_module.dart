import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import '../theme.dart';

class PowerModule extends StatelessWidget {
  const PowerModule({super.key});

  @override
  Widget build(BuildContext context) {
    return InnerShadowContainer(
      width: 49,
      height: 49,
      borderRadius: 24.5,
      backgroundColor: const Color(0xFFD9D9D9),
      blur: moduleShadowBlur.toDouble(),
      offset: moduleShadowOffset,
      shadowColor: Colors.black.withAlpha(moduleShadowAlpha),
      isShadowTopLeft: true,
      isShadowTopRight: true,
      isShadowBottomLeft: true,
      isShadowBottomRight: true,
      child: const SizedBox(),
    );
  }
}