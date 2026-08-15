import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../models/mensagem_eva.dart';

class ChatBubble extends StatelessWidget {
  final MensagemEva mensagem;

  const ChatBubble({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    final eva = mensagem.daEva;
    return Align(
      alignment: eva ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: eva ? AppColors.white : AppColors.navy,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(eva ? 4 : 16),
            bottomRight: Radius.circular(eva ? 16 : 4),
          ),
          border: eva ? Border.all(color: AppColors.line) : null,
        ),
        child: Text(
          mensagem.texto,
          style: TextStyle(
            color: eva ? AppColors.ink : AppColors.white,
            fontSize: 14.5,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}
