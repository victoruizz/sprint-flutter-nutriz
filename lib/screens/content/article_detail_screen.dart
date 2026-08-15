import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/artigo.dart';

/// Detalhe de UM artigo (recebido por parametro), com suas secoes.
class ArticleDetailScreen extends StatelessWidget {
  final Artigo artigo;

  const ArticleDetailScreen({super.key, required this.artigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artigo')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.pinkSoft,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              artigo.categoria,
              style: const TextStyle(
                color: AppColors.pink,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            artigo.titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(
                artigo.autor,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              const SizedBox(width: AppSpacing.md),
              const Icon(Icons.schedule, size: 16, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(
                '${artigo.minutosLeitura} min',
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final secao in artigo.secoes) ...[
            Text(
              secao.subtitulo,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              secao.texto,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.ink,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
