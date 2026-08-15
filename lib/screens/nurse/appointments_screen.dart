import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_agendamentos.dart';
import '../../widgets/agendamento_status_chip.dart';
import '../../widgets/section_card.dart';
import 'appointment_detail_screen.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: agendamentosMock.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final ag = agendamentosMock[i];
          return SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AppointmentDetailScreen(agendamento: ag),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ag.doadora,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    AgendamentoStatusChip(status: ag.status),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                _linha(Icons.place_outlined, ag.endereco),
                const SizedBox(height: 4),
                _linha(Icons.medical_services_outlined, 'Etapa: ${ag.etapa}'),
                const SizedBox(height: 4),
                _linha(Icons.schedule, dataHoraBr(ag.dataHora)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _linha(IconData icone, String texto) {
    return Row(
      children: [
        Icon(icone, size: 16, color: AppColors.blue),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            texto,
            style: const TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
