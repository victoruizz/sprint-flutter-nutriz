import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/artigo.dart';
import '../../widgets/content_container.dart';

/// Detalhe do artigo no mesmo desenho do ArticleCard.tsx do web-nutriz:
/// selo da categoria, titulo, linha de autor com data e validacao, capa,
/// bloco "O que voce vai aprender", corpo em secoes e a bio do autor.
class ArticleDetailScreen extends StatelessWidget {
  static const Color _fundo = Color(0xFFEEF2F7);
  static const Color _borda = Color(0xFFE4E4E7);
  static const Color _tinta = Color(0xFF09090B);
  static const Color _suave = Color(0xFF71717A);

  final Artigo artigo;

  const ArticleDetailScreen({super.key, required this.artigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fundo,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Artigo'),
      ),
      body: SingleChildScrollView(
        child: ContentContainer(
          larguraMaxima: 800,
          espacoAcima: 24,
          espacoAbaixo: 40,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borda),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _seloCategoria(),
                const SizedBox(height: 12),
                Text(
                  artigo.titulo,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: _tinta,
                  ),
                ),
                const SizedBox(height: 12),
                _linhaAutor(),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    artigo.imagem,
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                _blocoAprendizados(),
                const SizedBox(height: 24),
                ...artigo.secoes.map(_secao),
                const SizedBox(height: 8),
                _bioAutor(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _seloCategoria() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: artigo.fundoCategoria,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: artigo.corCategoria.withValues(alpha: 0.35)),
      ),
      child: Text(
        artigo.categoria,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: artigo.corCategoria,
        ),
      ),
    );
  }

  Widget _linhaAutor() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: artigo.fundoCategoria,
                shape: BoxShape.circle,
              ),
              child: Text(
                artigo.autorIniciais,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: artigo.corCategoria,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              artigo.autor,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3F3F46),
              ),
            ),
          ],
        ),
        Text('· ${artigo.data}',
            style: const TextStyle(fontSize: 13, color: _suave)),
        Text('· ${artigo.tempoLeitura}',
            style: const TextStyle(fontSize: 13, color: _suave)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 14, color: Color(0xFF059669)),
              SizedBox(width: 4),
              Text(
                'Validado por rBLH e Fiocruz',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF059669),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _blocoAprendizados() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: artigo.fundoCategoria,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: artigo.corCategoria.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: artigo.corCategoria),
              const SizedBox(width: 6),
              Text(
                'O QUE VOCE VAI APRENDER',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: artigo.corCategoria,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...artigo.aprendizados.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 16, color: artigo.corCategoria),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.35,
                        color: Color(0xFF3F3F46),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secao(SecaoArtigo secao) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            secao.subtitulo,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            secao.texto,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.65,
              color: Color(0xFF3F3F46),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bioAutor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borda),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: artigo.fundoCategoria,
              shape: BoxShape.circle,
            ),
            child: Text(
              artigo.autorIniciais,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: artigo.corCategoria,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artigo.autor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _tinta,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  artigo.autorBio,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: _suave,
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
