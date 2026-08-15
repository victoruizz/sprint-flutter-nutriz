import 'package:flutter/material.dart';

/// Paleta de marca do Nutriz, extraida do produto real (web-nutriz).
class AppColors {
  AppColors._();

  // Cores de marca
  static const Color navy = Color(0xFF00458B); // primario (header, titulos)
  static const Color blue = Color(0xFF387CCD); // azul de apoio / links
  static const Color teal = Color(0xFF0E9E94); // verde-agua (kit, sucesso)
  static const Color pink = Color(0xFFF2579F); // rosa (exames, destaque)
  static const Color purple = Color(0xFF84009E); // roxo (analise)

  // Fundos suaves por status/etapa
  static const Color blueSoft = Color(0xFFE1F1FB);
  static const Color tealSoft = Color(0xFFD9F7F4);
  static const Color pinkSoft = Color(0xFFFCF4F7);
  static const Color purpleSoft = Color(0xFFF2D4FF);

  // Neutros
  static const Color ink = Color(0xFF1F2937); // texto principal
  static const Color muted = Color(0xFF6B7280); // texto secundario
  static const Color line = Color(0xFFE5E7EB); // bordas / divisores
  static const Color surface = Color(0xFFF7F9FC); // fundo de tela
  static const Color white = Color(0xFFFFFFFF);

  // Gradiente da EVA (azul -> teal)
  static const LinearGradient evaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy, teal],
  );
}
