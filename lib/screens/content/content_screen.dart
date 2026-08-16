import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_artigos.dart';
import '../../models/artigo.dart';
import '../../widgets/content_container.dart';
import '../../widgets/page_title.dart';
import 'article_detail_screen.dart';

/// Central de conteudo educativo, seguindo o content-hub do web-nutriz:
/// um artigo em destaque com capa grande e os demais numa grade de cards.
class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destaque = artigosMock.first;
    final demais = artigosMock.skip(1).toList();

    return ContentContainer(
      larguraMaxima: 1100,
      child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        const PageTitle(
          titulo: 'Conteudo educativo',
          descricao:
              'Artigos, videos e guias praticos para acompanhar voce em cada '
              'etapa da doacao de leite materno.',
        ),
        _CardDestaque(artigo: destaque),
        const SizedBox(height: 28),
        const Text(
          'Todos os artigos',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.inkDeep,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final colunas = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 600
                    ? 2
                    : 1;
            const espaco = 16.0;
            final largura =
                (constraints.maxWidth - espaco * (colunas - 1)) / colunas;

            return Wrap(
              spacing: espaco,
              runSpacing: espaco,
              children: demais
                  .map((a) => SizedBox(
                        width: largura,
                        child: _CardArtigo(artigo: a),
                      ))
                  .toList(),
            );
          },
        ),
      ],
      ),
    );
  }
}

void _abrir(BuildContext context, Artigo artigo) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => ArticleDetailScreen(artigo: artigo)),
  );
}

class _CardDestaque extends StatelessWidget {
  final Artigo artigo;

  const _CardDestaque({required this.artigo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _abrir(context, artigo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              artigo.imagem,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(height: 10),
                  Text(
                    artigo.titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${artigo.autor} · ${artigo.tempoLeitura}',
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.white70),
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

class _CardArtigo extends StatelessWidget {
  final Artigo artigo;

  const _CardArtigo({required this.artigo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _abrir(context, artigo),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              artigo.imagem,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                  const SizedBox(height: 10),
                  Text(
                    artigo.titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: AppColors.inkDeep,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    artigo.resumo,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.slate,
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
