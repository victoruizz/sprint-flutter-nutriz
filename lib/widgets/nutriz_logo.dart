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

  /// Proporcao do arquivo original (516x135). A largura e fixada a partir da
  /// altura para o espaco da logo ja ficar reservado no primeiro frame - sem
  /// isso a imagem mede zero ate carregar e os vizinhos ocupam o lugar dela.
  static const double _proporcao = 516 / 135;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: altura,
      width: altura * _proporcao,
      child: Image.asset(
        light
            ? 'assets/images/nutriz-wordmark-white.png'
            : 'assets/images/nutriz-wordmark-blue.png',
        fit: BoxFit.contain,
        semanticLabel: 'Nutriz',
      ),
    );
  }
}
