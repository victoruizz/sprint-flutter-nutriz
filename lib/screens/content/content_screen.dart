import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_artigos.dart';
import '../../widgets/page_title.dart';
import '../../widgets/section_card.dart';
import 'article_detail_screen.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: artigosMock.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        if (i == 0) {
          return const PageTitle(
            titulo: 'Conteudo educativo',
            descricao: 'Conteudo validado por rBLH e Fiocruz.',
          );
        }

        final artigo = artigosMock[i - 1];
        return SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(artigo: artigo),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: artigo.fundoCategoria,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        artigo.categoria,
                        style: TextStyle(
                          color: artigo.corCategoria,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      artigo.tempoLeitura,
                      style:
                          const TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  artigo.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artigo.resumo,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
}
