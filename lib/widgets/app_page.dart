import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'content_container.dart';

/// Casca padrao das telas internas: barra superior navy e conteudo numa
/// coluna centralizada com respiro lateral, como o Layout.tsx + Page.tsx do
/// web-nutriz. Nenhuma tela deve encostar o conteudo na borda da janela.
class AppPage extends StatelessWidget {
  final String titulo;
  final Widget child;
  final double larguraMaxima;

  const AppPage({
    super.key,
    required this.titulo,
    required this.child,
    this.larguraMaxima = 1100,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.navy,
        elevation: 0,
        title: Text(titulo),
      ),
      body: ContentContainer(larguraMaxima: larguraMaxima, child: child),
    );
  }
}
