import 'package:flutter/material.dart';

class SecaoArtigo {
  final String subtitulo;
  final String texto;

  const SecaoArtigo({required this.subtitulo, required this.texto});
}

class Artigo {
  final String titulo;
  final String categoria;
  final String autor;
  final String resumo;
  final int minutosLeitura;

  /// Capa do artigo (assets/artigos/*.jpg, as mesmas imagens do web-nutriz).
  final String imagem;

  /// Cores da categoria, como no data.ts do front real.
  final Color corCategoria;
  final Color fundoCategoria;

  /// Data de publicacao, como no cabecalho do artigo no site.
  final String data;

  /// Mini biografia exibida ao pe do artigo.
  final String autorBio;

  /// Itens do bloco "O que voce vai aprender".
  final List<String> aprendizados;

  final List<SecaoArtigo> secoes;

  const Artigo({
    required this.titulo,
    required this.categoria,
    required this.autor,
    required this.resumo,
    required this.minutosLeitura,
    required this.imagem,
    required this.corCategoria,
    required this.fundoCategoria,
    required this.data,
    required this.autorBio,
    required this.aprendizados,
    required this.secoes,
  });

  String get tempoLeitura => '$minutosLeitura min de leitura';

  /// Iniciais do autor, usadas no avatar do artigo.
  String get autorIniciais => autor
      .split(' ')
      .where((p) => p.length > 2)
      .take(2)
      .map((p) => p[0])
      .join()
      .toUpperCase();
}
