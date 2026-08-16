import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_pontos.dart';
import '../../widgets/content_container.dart';
import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import 'point_detail_screen.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      larguraMaxima: 1100,
      child: ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      itemCount: pontosMock.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        if (i == 0) {
          return const PageTitle(
            titulo: 'Pontos de coleta',
            descricao: 'Bancos de leite e postos proximos de voce.',
          );
        }

        final ponto = pontosMock[i - 1];
        return SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PointDetailScreen(ponto: ponto),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        ponto.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    _StatusPonto(aberto: ponto.aberto),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${ponto.endereco} - ${ponto.bairro}, ${ponto.cidade}',
                  style: const TextStyle(
                      color: AppColors.muted, fontSize: 13, height: 1.3),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: 6,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.near_me_outlined,
                            size: 16, color: AppColors.blue),
                        const SizedBox(width: 4),
                        Text(
                          '${ponto.distanciaKm.toStringAsFixed(1)} km',
                          style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (ponto.coletaDomiciliar)
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Icon(Icons.home_outlined,
                          size: 16, color: AppColors.teal),
                      SizedBox(width: 4),
                      Text(
                        'Coleta domiciliar',
                        style: TextStyle(
                            color: AppColors.teal,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
        );
      },
      ),
    );
  }
}

class _StatusPonto extends StatelessWidget {
  final bool aberto;

  const _StatusPonto({required this.aberto});

  @override
  Widget build(BuildContext context) {
    final cor = aberto ? AppColors.teal : AppColors.muted;
    final fundo = aberto ? AppColors.tealSoft : const Color(0xFFF1F3F5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: fundo, borderRadius: BorderRadius.circular(999)),
      child: Text(
        aberto ? 'Aberto' : 'Fechado',
        style: TextStyle(color: cor, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
