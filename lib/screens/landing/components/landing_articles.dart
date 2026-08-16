import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_artigos.dart';
import '../../../models/artigo.dart';
import '../../../widgets/content_container.dart';
import '../../content/article_detail_screen.dart';
import 'section_label.dart';

/// Secao de artigos (ArticlesSection.tsx): fundo navy, selo de validacao
/// rBLH/Fiocruz e os quatro primeiros artigos do conteudo educativo.
class LandingArticles extends StatelessWidget {
  const LandingArticles({super.key});

  @override
  Widget build(BuildContext context) {
    final artigos = artigosMock.take(4).toList();

    return Container(
      width: double.infinity,
      color: AppColors.heroNavy,
      child: ContentContainer(
        espacoAcima: 48,
        espacoAbaixo: 56,
        child: Column(
        children: [
          const SectionLabel(
              texto: 'CONTEUDO DE APOIO', cor: AppColors.cyanDeep),
          const SizedBox(height: 16),
          const Text(
            'Artigos para te apoiar em cada fase',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F6EE),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 16, color: Color(0xFF12A35F)),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Conteudo validado por rBLH e Fiocruz',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF12A35F),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              // Mesma grade do site: 1 coluna no celular, 2 em telas medias
              // e 4 no desktop.
              final colunas = constraints.maxWidth >= 1000
                  ? 4
                  : constraints.maxWidth >= 640
                      ? 2
                      : 1;
              const espaco = 24.0;
              final largura =
                  (constraints.maxWidth - espaco * (colunas - 1)) / colunas;

              return Wrap(
                spacing: espaco,
                runSpacing: espaco,
                children: artigos
                    .map((artigo) => SizedBox(
                          width: largura,
                          child: _CardArtigo(artigo: artigo),
                        ))
                    .toList(),
              );
            },
          ),
        ],
        ),
      ),
    );
  }
}

class _CardArtigo extends StatelessWidget {
  final Artigo artigo;

  const _CardArtigo({required this.artigo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ArticleDetailScreen(artigo: artigo)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              artigo.imagem,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: artigo.fundoCategoria,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      artigo.categoria,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: artigo.corCategoria,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    artigo.titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.inkDeep,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          artigo.tempoLeitura,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.slateLight),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ler artigo',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: artigo.corCategoria,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 14, color: artigo.corCategoria),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
