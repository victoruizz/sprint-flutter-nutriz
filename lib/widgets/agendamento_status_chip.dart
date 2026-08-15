import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/agendamento.dart';

class AgendamentoStatusChip extends StatelessWidget {
  final StatusAgendamento status;

  const AgendamentoStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (Color fg, Color bg, String label) = switch (status) {
      StatusAgendamento.aguardando => (
          AppColors.navy,
          AppColors.blueSoft,
          'Aguardando',
        ),
      StatusAgendamento.realizada => (
          AppColors.teal,
          AppColors.tealSoft,
          'Realizada',
        ),
      StatusAgendamento.naoRealizada => (
          AppColors.pink,
          AppColors.pinkSoft,
          'Nao realizada',
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        label,
        style:
            TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11.5),
      ),
    );
  }
}
