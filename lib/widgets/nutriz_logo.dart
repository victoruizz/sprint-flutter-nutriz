import 'package:flutter/material.dart';

/// Wordmark oficial do Nutriz, mesma imagem usada no web-nutriz
/// (assets/images/nutriz-wordmark-{white,blue}.png).
///
/// [altura] e a altura do wordmark em pixels logicos - a largura acompanha
/// proporcionalmente. Use [light] em fundos escuros (navy) e false em fundo
/// claro.
class NutrizLogo extends StatelessWidget {
  final double altura;
  final bool light;

  const NutrizLogo({super.key, this.altura = 28, this.light = true});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      light
          ? 'assets/images/nutriz-wordmark-white.png'
          : 'assets/images/nutriz-wordmark-blue.png',
      height: altura,
      fit: BoxFit.contain,
      semanticLabel: 'Nutriz',
    );
  }
}
