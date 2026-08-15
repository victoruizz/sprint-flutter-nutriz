import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_doacoes.dart';
import '../../models/etapa_doacao.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_badge.dart';
import 'donation_detail_screen.dart';

/// Lista das doacoes da nutriz. Tocar num card abre o detalhe daquela doacao.
class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas doacoes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: doacoesMock.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final doacao = doacoesMock[i];
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
                        doacao.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
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
                  'Iniciada em ${dataBr(doacao.dataInicio)}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  doacao.concluida
                      ? 'Doacao concluida - obrigada!'
                      : 'Etapa atual: ${doacao.statusAtual}',
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: doacao.progresso,
                    minHeight: 6,
                    backgroundColor: AppColors.line,
                    valueColor: const AlwaysStoppedAnimation(AppColors.teal),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
