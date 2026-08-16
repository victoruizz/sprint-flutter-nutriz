import 'package:flutter/material.dart';

/// Container de conteudo do web-nutriz: `mx-auto max-w-[1200px] px-5 lg:px-8`.
///
/// Centraliza o conteudo e limita a largura, com respiro lateral que cresce
/// em telas maiores. O fundo continua ocupando a largura toda - so o conteudo
/// e que fica contido, como no site.
class ContentContainer extends StatelessWidget {
  final Widget child;

  /// Largura maxima do conteudo. O site usa 1200 na maioria das secoes e
  /// faixas mais estreitas em blocos como depoimentos (760).
  final double larguraMaxima;

  final double espacoAcima;
  final double espacoAbaixo;

  const ContentContainer({
    super.key,
    required this.child,
    this.larguraMaxima = 1200,
    this.espacoAcima = 0,
    this.espacoAbaixo = 0,
  });

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.sizeOf(context).width;
    final padding = largura >= 1024 ? 32.0 : 20.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: larguraMaxima + padding * 2),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            padding,
            espacoAcima,
            padding,
            espacoAbaixo,
          ),
          child: child,
        ),
      ),
    );
  }
}
