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
  final List<SecaoArtigo> secoes;

  const Artigo({
    required this.titulo,
    required this.categoria,
    required this.autor,
    required this.resumo,
    required this.minutosLeitura,
    required this.secoes,
  });
}
