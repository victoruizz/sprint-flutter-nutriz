import 'package:flutter/material.dart';

import '../screens/eva/eva_chat_panel.dart';

/// Abre a EVA como painel flutuante no canto inferior direito, do mesmo jeito
/// que o widget do web-nutriz (.eva-widget-modal): 400x620 com cantos
/// arredondados e sombra, virando tela cheia em telas estreitas.
///
/// A EVA nao e uma pagina no produto real - e um widget global que abre por
/// cima do conteudo, entao aqui tambem nao usamos navegacao de tela.
Future<void> mostrarEvaWidget(BuildContext context, {String? perguntaInicial}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar chat da EVA',
    barrierColor: Colors.black.withValues(alpha: 0.28),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, _, __) => _PainelFlutuanteEva(
      perguntaInicial: perguntaInicial,
    ),
    transitionBuilder: (context, animacao, _, filho) {
      final curva = CurvedAnimation(parent: animacao, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curva,
        // A entrada cresce a partir do canto do botao flutuante.
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1).animate(curva),
          alignment: Alignment.bottomRight,
          child: filho,
        ),
      );
    },
  );
}

class _PainelFlutuanteEva extends StatelessWidget {
  final String? perguntaInicial;

  const _PainelFlutuanteEva({this.perguntaInicial});

  @override
  Widget build(BuildContext context) {
    final tela = MediaQuery.sizeOf(context);
    // Abaixo de 520px o widget ocupa a tela inteira, como no CSS original.
    final telaCheia = tela.width < 520;

    final painel = Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(telaCheia ? 0 : 24),
      clipBehavior: Clip.antiAlias,
      elevation: telaCheia ? 0 : 20,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      child: SizedBox(
        width: telaCheia ? tela.width : 400,
        height: telaCheia ? tela.height : 620,
        child: EvaChatPanel(
          perguntaInicial: perguntaInicial,
          onFechar: () => Navigator.of(context).pop(),
        ),
      ),
    );

    if (telaCheia) return painel;

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: tela.width - 40,
            maxHeight: tela.height - 40,
          ),
          child: painel,
        ),
      ),
    );
  }
}
