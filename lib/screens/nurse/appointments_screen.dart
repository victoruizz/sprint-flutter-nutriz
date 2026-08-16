import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_agendamentos.dart';
import '../../models/agendamento.dart';
import '../../widgets/agendamento_status_chip.dart';
import '../../widgets/content_container.dart';
import '../../widgets/page_title.dart';
import 'appointment_detail_screen.dart';

/// Agendamentos atribuidos a enfermagem, seguindo pages/private/job/list do
/// web-nutriz: abas de status, filtro de data e cards com doadora, data,
/// local e etapa da doacao.
class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF9CA3AF);

  StatusAgendamento _status = StatusAgendamento.aguardando;

  @override
  Widget build(BuildContext context) {
    final lista =
        agendamentosMock.where((a) => a.status == _status).toList();

    return ContentContainer(
      larguraMaxima: 1200,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: PageTitle(
                  titulo: 'Agendamentos atribuidos',
                  descricao:
                      'Toque em um card para ver os detalhes e o relatorio '
                      'da consulta.',
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FB),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${lista.length} agendamentos',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
          _abas(),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFE5EAF0)),
          const SizedBox(height: 16),
          if (lista.isEmpty)
            _vazio()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final duasColunas = constraints.maxWidth >= 820;
                const espaco = 16.0;
                final largura = duasColunas
                    ? (constraints.maxWidth - espaco) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: espaco,
                  runSpacing: espaco,
                  children: lista
                      .map((a) => SizedBox(
                            width: largura,
                            child: _CardAgendamento(agendamento: a),
                          ))
                      .toList(),
                );
              },
            ),
        ],
      ),
    );
  }

  /// Abas de status em pilula (StatusTabs.tsx).
  Widget _abas() {
    const abas = [
      (StatusAgendamento.aguardando, 'Em Andamento'),
      (StatusAgendamento.realizada, 'Concluido'),
      (StatusAgendamento.naoRealizada, 'Com Erro'),
    ];

    // `overflow-x-auto` do site: em tela estreita as abas rolam na horizontal
    // em vez de estourar a linha.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2F7),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: abas.map((aba) {
            final ativo = aba.$1 == _status;
            return GestureDetector(
              onTap: () => setState(() => _status = aba.$1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: ativo ? AppColors.navy : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  aba.$2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ativo ? AppColors.white : const Color(0xFF6B7280),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _vazio() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: const Column(
        children: [
          Icon(Icons.event_busy, size: 32, color: Color(0xFFC0C7D1)),
          SizedBox(height: 8),
          Text(
            'Nenhum agendamento encontrado',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _tinta,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Ajuste o periodo ou a aba selecionada.',
            style: TextStyle(fontSize: 13, color: _cinza),
          ),
        ],
      ),
    );
  }
}

class _CardAgendamento extends StatelessWidget {
  final Agendamento agendamento;

  const _CardAgendamento({required this.agendamento});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AppointmentDetailScreen(agendamento: agendamento),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE7ECF2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.blueSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    agendamento.doadora
                        .split(' ')
                        .take(2)
                        .map((p) => p[0])
                        .join()
                        .toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4A77B0),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        agendamento.doadora,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _CardAgendamento._tinta,
                        ),
                      ),
                      const Text(
                        'Doadora',
                        style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                      ),
                    ],
                  ),
                ),
                AgendamentoStatusChip(status: agendamento.status),
              ],
            ),
            const SizedBox(height: 16),
            _linha(Icons.calendar_today_outlined, 'Data do agendamento',
                dataHoraBr(agendamento.dataHora)),
            _linha(Icons.place_outlined, 'Local do agendamento',
                agendamento.endereco),
            _linha(Icons.bookmark_border, 'Etapa da doacao',
                agendamento.etapa),
            const SizedBox(height: 6),
            Container(height: 1, color: const Color(0xFFEEF1F5)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.description_outlined,
                    size: 16, color: AppColors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    agendamento.status == StatusAgendamento.aguardando
                        ? 'Registrar relatorio da consulta'
                        : 'Ver relatorio da consulta',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right,
                    size: 16, color: AppColors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const Color _tinta = Color(0xFF1F2A37);

  Widget _linha(IconData icone, String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, size: 18, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rotulo,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF9CA3AF)),
                ),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _tinta,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
