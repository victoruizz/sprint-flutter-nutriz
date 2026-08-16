import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';
import '../../../widgets/content_container.dart';

/// Faixa de metricas que sobrepoe o hero (StatsBar.tsx + MetricCard.tsx).
class LandingStats extends StatelessWidget {
  const LandingStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.canvas,
      child: ContentContainer(
        larguraMaxima: 1100,
        espacoAcima: 24,
        espacoAbaixo: 8,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // No site as tres metricas ficam lado a lado a partir de lg.
            final emLinha = constraints.maxWidth >= 720;
            final cartoes = metricasLanding
                .map((m) => _MetricCard(metrica: m))
                .toList();

            if (emLinha) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < cartoes.length; i++) ...[
                    if (i > 0) const SizedBox(width: 24),
                    Expanded(child: cartoes[i]),
                  ],
                ],
              );
            }

            return Column(
              children: [
                for (final cartao in cartoes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: cartao,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final MetricaLanding metrica;

  const _MetricCard({required this.metrica});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hairline),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroNavy.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: metrica.fundoIcone,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(metrica.icone, color: metrica.corIcone, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metrica.valor,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: metrica.corIcone,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  metrica.rotulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkDeep,
                  ),
                ),
                Text(
                  metrica.subRotulo,
                  style: const TextStyle(
                      fontSize: 12.5, color: AppColors.slateLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
