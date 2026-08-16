import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/etapa_doacao.dart';

class StatusBadge extends StatelessWidget {
  final StatusEtapa status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final ({String label, Color fg, Color bg}) estilo = switch (status) {
      StatusEtapa.concluida => (
          label: 'Concluida',
          fg: AppColors.teal,
          bg: AppColors.tealSoft,
        ),
      StatusEtapa.emAndamento => (
          label: 'Em andamento',
          fg: AppColors.navy,
          bg: AppColors.blueSoft,
        ),
      StatusEtapa.pendente => (
          label: 'Pendente',
          fg: AppColors.muted,
          bg: const Color(0xFFF1F3F5),
        ),
      StatusEtapa.erro => (
          label: 'Com erro',
          fg: const Color(0xFFA32D2D),
          bg: const Color(0xFFFCEBEB),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: estilo.bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: estilo.fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            estilo.label,
            style: TextStyle(
              color: estilo.fg,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
