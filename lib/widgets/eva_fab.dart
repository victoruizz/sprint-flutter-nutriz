import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Botao flutuante que abre o chat da EVA, igual ao `.eva-fab` do web-nutriz:
/// circulo de 60px no canto inferior direito, com o gradiente rosa/lilas da
/// assistente e sombra roxa.
class EvaFab extends StatelessWidget {
  final VoidCallback onPressed;

  const EvaFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir chat com a EVA',
      child: Tooltip(
        message: 'Falar com a EVA',
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF0A0BE), Color(0xFFB79CE0)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB46BD9).withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: AppColors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
