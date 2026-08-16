import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_dashboard.dart';
import '../../widgets/content_container.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/page_title.dart';

/// Painel administrativo, seguindo pages/private/dashboard do web-nutriz:
/// filtro de periodo, litros captados por mes, doacoes ativas por etapa,
/// nivel de satisfacao, taxa de recorrencia, tempo medio de resposta e
/// doacoes com erro.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF9CA3AF);

  String _periodo = periodosDashboard.first;

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      larguraMaxima: 1400,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const PageTitle(
            titulo: 'Dashboard',
            descricao:
                'Indicadores consolidados de todas as doadoras - atualizado '
                'em tempo real',
          ),
          FilterChips<String>(
            opcoes: periodosDashboard
                .map((p) => (valor: p, rotulo: p))
                .toList(),
            selecionado: _periodo,
            onSelecionar: (p) => setState(() => _periodo = p),
          ),
          const SizedBox(height: 24),
          _cardLitros(),
          const SizedBox(height: 24),
          _duasColunas(_cardEtapas(), _cardSatisfacao()),
          const SizedBox(height: 24),
          _duasColunas(_cardRecorrencia(), _cardTempoResposta()),
          const SizedBox(height: 24),
          _cardErro(),
        ],
      ),
    );
  }

  Widget _duasColunas(Widget esquerda, Widget direita) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: esquerda),
              const SizedBox(width: 24),
              Expanded(child: direita),
            ],
          );
        }
        return Column(
          children: [esquerda, const SizedBox(height: 24), direita],
        );
      },
    );
  }

  Widget _cardLitros() {
    final total = leitePorMesMock.fold<int>(0, (s, m) => s + m.litros);
    final maior = leitePorMesMock
        .map((m) => m.litros)
        .reduce((a, b) => a > b ? a : b);
    final mesAtual = leitePorMesMock.last.mes;

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: DashboardCardHeader(
                  icone: Icons.water_drop_outlined,
                  corIcone: AppColors.navy,
                  fundoIcone: Color(0xFFEAF4FC),
                  titulo: 'Litros Captados por Mes',
                  subtitulo:
                      'Volume total de leite coletado, todas as doadoras',
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$total L',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                  const Text(
                    'Total no periodo',
                    style: TextStyle(fontSize: 12, color: _cinza),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _legenda(AppColors.navy, 'Mes vigente'),
              const SizedBox(width: 16),
              _legenda(const Color(0xFFBFE0F5), 'Meses anteriores'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: leitePorMesMock.map((m) {
                final atual = m.mes == mesAtual;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${m.litros}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _tinta,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: (m.litros / maior) * 150,
                          decoration: BoxDecoration(
                            color:
                                atual ? AppColors.navy : const Color(0xFFBFE0F5),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m.mes,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legenda(Color cor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(texto,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      ],
    );
  }

  Widget _cardEtapas() {
    final total = doacoesPorEtapaMock.fold<int>(0, (s, e) => s + e.total);
    const tons = [
      Color(0xFF00458B),
      Color(0xFF1A5C9E),
      Color(0xFF3474B1),
      Color(0xFF4E8CC4),
      Color(0xFF68A4D7),
      Color(0xFF82BCEA),
    ];

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardCardHeader(
            icone: Icons.checklist,
            corIcone: AppColors.navy,
            fundoIcone: Color(0xFFEAF4FC),
            titulo: 'Doacoes Ativas por Etapa',
            subtitulo: 'Distribuicao das doacoes em andamento no periodo',
          ),
          const SizedBox(height: 20),
          ...doacoesPorEtapaMock.asMap().entries.map((entrada) {
            final e = entrada.value;
            final pct = ((e.total / total) * 100).round();
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '$pct%',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: pct / 100,
                        minHeight: 24,
                        backgroundColor: const Color(0xFFEEF2F7),
                        valueColor: AlwaysStoppedAnimation(
                          tons[entrada.key % tons.length],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 150,
                    child: Text(
                      '${e.etapa} (${e.total})',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: _tinta),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          const SizedBox(height: 12),
          const Text('Total de doacoes ativas',
              style: TextStyle(fontSize: 11, color: _cinza)),
          Text(
            '$total',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardSatisfacao() {
    final total = avaliacoesMock.fold<int>(0, (s, a) => s + a.total);
    final maior =
        avaliacoesMock.map((a) => a.total).reduce((a, b) => a > b ? a : b);
    final media = avaliacoesMock.fold<double>(
            0, (s, a) => s + a.estrelas * a.total) /
        total;
    final positivas = avaliacoesMock
        .where((a) => a.estrelas >= 4)
        .fold<int>(0, (s, a) => s + a.total);
    final pctPositivas = ((positivas / total) * 100).round();

    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardCardHeader(
            icone: Icons.star_outline,
            corIcone: AppColors.pink,
            fundoIcone: Color(0xFFFDEBF3),
            titulo: 'Nivel de Satisfacao',
            subtitulo: 'Distribuicao de avaliacoes por estrela',
          ),
          const SizedBox(height: 20),
          ...avaliacoesMock.map((a) {
            final pct = ((a.total / total) * 100).round();
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      '${a.estrelas} estrela${a.estrelas > 1 ? 's' : ''}',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF4B5563)),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: a.total / maior,
                        minHeight: 20,
                        backgroundColor: const Color(0xFFF4F4F5),
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.pink
                              .withValues(alpha: 0.35 + 0.13 * a.estrelas),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 74,
                    child: Text(
                      '${a.total} ($pct%)',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 12, color: _cinza),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          const SizedBox(height: 12),
          Row(
            children: [
              _resumo('Avaliacoes no periodo', '$total', _tinta),
              const SizedBox(width: 28),
              _resumo(
                  'Nota Media', media.toStringAsFixed(1), AppColors.pink),
              const SizedBox(width: 28),
              _resumo('4 ou 5 Estrelas', '$pctPositivas%', _tinta),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resumo(String rotulo, String valor, Color cor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rotulo, style: const TextStyle(fontSize: 11, color: _cinza)),
        const SizedBox(height: 2),
        Text(
          valor,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cor,
          ),
        ),
      ],
    );
  }

  Widget _cardRecorrencia() {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardCardHeader(
            icone: Icons.refresh,
            corIcone: AppColors.pink,
            fundoIcone: Color(0xFFFDEBF3),
            titulo: 'Taxa de Recorrencia de Doadoras',
            subtitulo: 'Doadoras que ajudaram mais de uma vez',
          ),
          const SizedBox(height: 20),
          Text(
            '${taxaRecorrenciaMock.toInt()}%',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: taxaRecorrenciaMock / 100,
              minHeight: 32,
              backgroundColor: const Color(0xFF9CA3AF).withValues(alpha: 0.13),
              valueColor:
                  AlwaysStoppedAnimation(AppColors.pink.withValues(alpha: 0.8)),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0%', style: TextStyle(fontSize: 11, color: _cinza)),
              Text('50%', style: TextStyle(fontSize: 11, color: _cinza)),
              Text('100%', style: TextStyle(fontSize: 11, color: _cinza)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardTempoResposta() {
    return _statCard(
      icone: Icons.schedule,
      corIcone: AppColors.navy,
      fundoIcone: const Color(0xFFE1F1FB),
      titulo: 'Tempo Medio de Resposta',
      subtitulo: 'Triagem ate a 1a coleta agendada',
      valor: '${tempoMedioRespostaHorasMock.toStringAsFixed(1)}h'
          .replaceAll('.', ','),
      rodape: 'Media de horas ate o primeiro agendamento',
      corValor: _tinta,
    );
  }

  Widget _cardErro() {
    return _statCard(
      icone: Icons.warning_amber_outlined,
      corIcone: AppColors.pink,
      fundoIcone: const Color(0xFFFDEBF3),
      titulo: 'Doacoes com Erro',
      subtitulo: 'Ocorrencias no periodo selecionado',
      valor: '$doacoesComErroMock',
      rodape: 'Doacoes que nao puderam ser concluidas',
      corValor: AppColors.pink,
    );
  }

  Widget _statCard({
    required IconData icone,
    required Color corIcone,
    required Color fundoIcone,
    required String titulo,
    required String subtitulo,
    required String valor,
    required String rodape,
    required Color corValor,
  }) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardCardHeader(
            icone: icone,
            corIcone: corIcone,
            fundoIcone: fundoIcone,
            titulo: titulo,
            subtitulo: subtitulo,
          ),
          const SizedBox(height: 22),
          Text(
            valor,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              height: 1,
              color: corValor,
            ),
          ),
          const SizedBox(height: 4),
          Text(rodape, style: const TextStyle(fontSize: 12, color: _cinza)),
        ],
      ),
    );
  }
}
