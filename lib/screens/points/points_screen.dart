import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_pontos.dart';
import '../../models/ponto_coleta.dart';
import '../../widgets/section_card.dart';
import 'point_detail_screen.dart';

/// Lista de pontos de coleta. Tocar num card abre o detalhe daquele ponto.
class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pontos de coleta')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: pontosMock.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final ponto = pontosMock[i];
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
                  style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.3),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(Icons.near_me_outlined, size: 16, color: AppColors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${ponto.distanciaKm.toStringAsFixed(1)} km',
                      style: const TextStyle(color: AppColors.ink, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    if (ponto.coletaDomiciliar) ...[
                      const SizedBox(width: AppSpacing.md),
                      const Icon(Icons.home_outlined, size: 16, color: AppColors.teal),
                      const SizedBox(width: 4),
                      const Text(
                        'Coleta domiciliar',
                        style: TextStyle(color: AppColors.teal, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
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

/// Etiqueta de aberto/fechado do ponto de coleta.
class _StatusPonto extends StatelessWidget {
  final bool aberto;

  const _StatusPonto({required this.aberto});

  @override
  Widget build(BuildContext context) {
    final cor = aberto ? AppColors.teal : AppColors.muted;
    final fundo = aberto ? AppColors.tealSoft : const Color(0xFFF1F3F5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: fundo, borderRadius: BorderRadius.circular(999)),
      child: Text(
        aberto ? 'Aberto' : 'Fechado',
        style: TextStyle(color: cor, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
