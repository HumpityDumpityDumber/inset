import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../theme.dart';

class PowerModule extends StatelessWidget {
  const PowerModule({super.key});

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
        width: 49,
        height: 49,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}