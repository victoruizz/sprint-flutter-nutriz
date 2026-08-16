import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_doacoes.dart';
import '../../models/etapa_doacao.dart';
import '../../widgets/content_container.dart';
import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_badge.dart';
import 'donation_detail_screen.dart';
import 'new_donation_screen.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      larguraMaxima: 1100,
      child: ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      itemCount: doacoesMock.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        if (i == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle(
                titulo: 'Minhas doacoes',
                descricao: 'Acompanhe cada etapa das suas doacoes.',
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(0, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NewDonationScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(
                    'Nova doacao',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        }

        final doacao = doacoesMock[i - 1];
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
