import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color navy = Color(0xFF00458B);
  static const Color blue = Color(0xFF387CCD);
  static const Color teal = Color(0xFF0E9E94);
  static const Color pink = Color(0xFFF2579F);
  static const Color purple = Color(0xFF84009E);

  static const Color blueSoft = Color(0xFFE1F1FB);
  static const Color tealSoft = Color(0xFFD9F7F4);
  static const Color pinkSoft = Color(0xFFFCF4F7);
  static const Color purpleSoft = Color(0xFFF2D4FF);

  static const Color ink = Color(0xFF1F2937);
  static const Color muted = Color(0xFF6B7280);
  static const Color line = Color(0xFFE5E7EB);
  static const Color surface = Color(0xFFF7F9FC);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient evaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy, teal],
  );
}
