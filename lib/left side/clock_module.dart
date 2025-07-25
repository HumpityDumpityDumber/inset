import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import 'dart:async';

class ClockModule extends StatefulWidget {
  const ClockModule({super.key});

  @override
  State<ClockModule> createState() => _ClockModuleState();
}

class _ClockModuleState extends State<ClockModule> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = int.parse(DateFormat('hh').format(now));
    final minute = DateFormat('mm').format(now);
    setState(() {
      _timeString = '$hour:$minute';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerShadowContainer(
      width: 160,
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
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          _timeString,
          style: GoogleFonts.inter(
            fontSize: 20.5,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}