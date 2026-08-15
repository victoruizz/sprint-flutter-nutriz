import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Gestao de doacoes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: doacoesMock.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
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
}
