import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/content_container.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/page_title.dart';
import '../../data/mock_doacoes.dart';
import '../../models/etapa_doacao.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_badge.dart';
import '../donations/donation_detail_screen.dart';

class DonationsAdminScreen extends StatelessWidget {
  const DonationsAdminScreen({super.key});

  static const List<String> _doadoras = [
    'Mariana Alves',
    'Fernanda Lima',
    'Beatriz Ramos',
  ];

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      larguraMaxima: 1400,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        itemCount: doacoesMock.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, indice) {
          if (indice == 0) return _cabecalho(context);

          final i = indice - 1;
          final doacao = doacoesMock[i];
          final doadora = _doadoras[i % _doadoras.length];
          return SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DonationDetailScreen(doacao: doacao),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        doadora,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    StatusBadge(
                      status: doacao.concluida
                          ? StatusEtapa.concluida
                          : StatusEtapa.emAndamento,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${doacao.id} - iniciada em ${dataBr(doacao.dataInicio)}',
                  style:
                      const TextStyle(color: AppColors.muted, fontSize: 12.5),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Etapa atual: ${doacao.statusAtual}',
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Titulo, buscas e filtros da lista, como o cabecalho da tela de gestao de
  /// doacoes do web-nutriz.
  Widget _cabecalho(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          titulo: 'Gestao de Doacoes',
          descricao: '${doacoesMock.length} doacoes cadastradas',
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 700) {
              return const Row(
                children: [
                  Expanded(child: SearchBarNutriz(dica: 'Buscar por nome...')),
                  SizedBox(width: 12),
                  Expanded(child: SearchBarNutriz(dica: 'Buscar por CPF...')),
                ],
              );
            }
            return const Column(
              children: [
                SearchBarNutriz(dica: 'Buscar por nome...'),
                SizedBox(height: 10),
                SearchBarNutriz(dica: 'Buscar por CPF...'),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        FilterChips<String>(
          opcoes: const [
            (valor: 'todas', rotulo: 'Todas'),
            (valor: 'ativas', rotulo: 'Ativas'),
            (valor: 'concluidas', rotulo: 'Concluidas'),
          ],
          selecionado: 'todas',
          onSelecionar: (_) {},
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
