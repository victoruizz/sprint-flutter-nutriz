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

  // Tons da landing/header do web-nutriz (hex identicos aos do front real).
  static const Color heroNavy = Color(0xFF0A3A87);
  static const Color footerNavy = Color(0xFF082F6E);
  static const Color drawerBlue = Color(0xFF1B4FBB);
  static const Color cyan = Color(0xFF72F2EB);
  static const Color cyanDeep = Color(0xFF2FD9C5);
  static const Color onNavy = Color(0xFFC7D6F0);
  static const Color onNavyMuted = Color(0xFF9FB6DC);
  static const Color inkDeep = Color(0xFF12294D);
  static const Color slate = Color(0xFF64748B);
  static const Color slateLight = Color(0xFF94A3B8);
  static const Color canvas = Color(0xFFF5F7FB);

  /// Fundo do app autenticado (Layout.tsx do web-nutriz).
  static const Color appBg = Color(0xFFF7F7FA);
  static const Color hairline = Color(0xFFE6ECF5);

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
