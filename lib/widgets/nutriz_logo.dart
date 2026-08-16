import 'package:flutter/material.dart';

/// Wordmark oficial do Nutriz, com os mesmos arquivos do web-nutriz.
///
/// Em fundo escuro usa a versao branca (`nutriz-wordmark-white.png`, a mesma
/// do header do site). Em fundo claro usa a logo colorida
/// (`nutriz-logo-color.png`, gerada a partir do `nutriz-logo.svg` original) -
/// a wordmark azul do repositorio traz o "nu" em branco e some no claro.
///
/// [altura] e a altura em pixels logicos; a largura acompanha a proporcao do
/// arquivo, para o espaco ja ficar reservado antes de a imagem carregar.
class NutrizLogo extends StatelessWidget {
  static const double _proporcaoBranca = 516 / 135;
  static const double _proporcaoColorida = 856 / 232;

  final double altura;
  final bool light;

  const NutrizLogo({super.key, this.altura = 28, this.light = true});

  @override
  Widget build(BuildContext context) {
    final proporcao = light ? _proporcaoBranca : _proporcaoColorida;

    return Image.asset(
      light
          ? 'assets/images/nutriz-wordmark-white.png'
          : 'assets/images/nutriz-logo-color.png',
      height: altura,
      width: altura * proporcao,
      fit: BoxFit.contain,
      semanticLabel: 'Nutriz',
    );
  }
}
