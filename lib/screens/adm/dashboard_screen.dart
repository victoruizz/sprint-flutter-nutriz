import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_dashboard.dart';
import '../../data/mock_sessao.dart';
import '../../widgets/section_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxEtapa =
        doacoesPorEtapaMock.map((e) => e.total).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: const Text('Painel')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Ola, ${adminMock.primeiroNome}!',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Visao geral das doacoes no periodo.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (int i = 0; i < metricasMock.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _MetricCard(metrica: metricasMock[i])),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: _MetricCard(metrica: metricasMock[i + 1])),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Doacoes ativas por etapa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SectionCard(
            child: Column(
              children: [
                for (final e in doacoesPorEtapaMock)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                e.etapa,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  color: AppColors.ink,
                                ),
                              ),
                            ),
                            Text(
                              '${e.total}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: e.total / maxEtapa,
                            minHeight: 6,
                            backgroundColor: AppColors.line,
                            valueColor:
                                const AlwaysStoppedAnimation(AppColors.blue),
                          ),
                        ),
                      ],
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

class _MetricCard extends StatelessWidget {
  final MetricaDashboard metrica;

  const _MetricCard({required this.metrica});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metrica.valor,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            metrica.titulo,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            metrica.subtitulo,
            style: const TextStyle(
                color: AppColors.muted, fontSize: 11.5, height: 1.3),
          ),
        ],
      ),
    );
  }
}
