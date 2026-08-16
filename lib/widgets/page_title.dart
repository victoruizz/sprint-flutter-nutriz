import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Titulo de pagina exibido dentro do conteudo, como o Page.tsx do
/// web-nutriz - o header do app so carrega a wordmark, entao o nome da area
/// aparece aqui.
class PageTitle extends StatelessWidget {
  final String titulo;
  final String? descricao;

  const PageTitle({super.key, required this.titulo, this.descricao});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0E2A45),
          ),
        ),
        if (descricao != null) ...[
          const SizedBox(height: 6),
          Text(
            descricao!,
            style: const TextStyle(fontSize: 13.5, color: AppColors.muted),
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }
}
