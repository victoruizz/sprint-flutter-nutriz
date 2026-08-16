import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/doacao.dart';
import '../../widgets/app_page.dart';
import '../../widgets/section_card.dart';
import '../../widgets/timeline_tile.dart';

class DonationDetailScreen extends StatelessWidget {
  final Doacao doacao;

  const DonationDetailScreen({super.key, required this.doacao});

  @override
  Widget build(BuildContext context) {
    final etapas = doacao.etapas;

    return AppPage(
      titulo: doacao.id,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doacao.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Iniciada em ${dataBr(doacao.dataInicio)}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: doacao.progresso,
                    minHeight: 8,
                    backgroundColor: AppColors.line,
                    valueColor: const AlwaysStoppedAnimation(AppColors.teal),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${doacao.etapasConcluidas} de ${etapas.length} etapas concluidas',
                  style:
                      const TextStyle(color: AppColors.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              'Linha do tempo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
          ),
          for (int i = 0; i < etapas.length; i++)
            TimelineTile(etapa: etapas[i], ultima: i == etapas.length - 1),
        ],
      ),
    );
  }
}
