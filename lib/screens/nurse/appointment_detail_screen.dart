import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/agendamento.dart';
import '../../widgets/agendamento_status_chip.dart';
import '../../widgets/info_row.dart';
import '../../widgets/section_card.dart';

/// Detalhe de UM agendamento (recebido por parametro), na visao do enfermeiro.
class AppointmentDetailScreen extends StatelessWidget {
  final Agendamento agendamento;

  const AppointmentDetailScreen({super.key, required this.agendamento});

  void _preencherRelatorio(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Relatorio de ${agendamento.doadora} registrado.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamento')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  agendamento.doadora,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ),
              AgendamentoStatusChip(status: agendamento.status),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionCard(
            child: Column(
              children: [
                InfoRow(
                  icone: Icons.place_outlined,
                  label: 'Endereco',
                  valor: agendamento.endereco,
                ),
                InfoRow(
                  icone: Icons.medical_services_outlined,
                  label: 'Etapa',
                  valor: agendamento.etapa,
                ),
                InfoRow(
                  icone: Icons.schedule,
                  label: 'Data e hora',
                  valor: dataHoraBr(agendamento.dataHora),
                ),
                InfoRow(
                  icone: Icons.flag_outlined,
                  label: 'Situacao',
                  valor: agendamento.statusLabel,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (agendamento.status == StatusAgendamento.aguardando)
            ElevatedButton.icon(
              onPressed: () => _preencherRelatorio(context),
              icon: const Icon(Icons.assignment_turned_in_outlined),
              label: const Text('Preencher relatorio'),
            ),
        ],
      ),
    );
  }
}
