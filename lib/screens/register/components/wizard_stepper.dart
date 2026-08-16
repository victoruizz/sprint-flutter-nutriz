import 'package:flutter/material.dart';

/// Indicador de etapas do cadastro, igual ao Stepper.tsx do web-nutriz:
/// circulos numerados ligados por uma linha, com marca de concluido e
/// destaque na etapa atual.
class WizardStepper extends StatelessWidget {
  static const Color azul = Color(0xFF0D3B6E);
  static const Color linhaInativa = Color(0xFFE4E4E7);
  static const Color textoInativo = Color(0xFFA1A1AA);

  final List<String> etapas;
  final int atual;
  final int maxVisitada;
  final ValueChanged<int> onEtapaTocada;

  const WizardStepper({
    super.key,
    required this.etapas,
    required this.atual,
    required this.maxVisitada,
    required this.onEtapaTocada,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Como no site (`hidden sm:block`), os rotulos so aparecem quando ha
        // espaco - em tela estreita ficam so os numeros.
        final mostrarRotulos = constraints.maxWidth >= 520;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < etapas.length; i++) ...[
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: i <= atual ? azul : linhaInativa,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    transform: Matrix4.translationValues(0, 16, 0),
                  ),
                ),
              _Etapa(
                indice: i,
                rotulo: mostrarRotulos ? etapas[i] : null,
                concluida: i < atual,
                ativa: i == atual,
                visitada: i <= maxVisitada,
                onTap: () => onEtapaTocada(i),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Etapa extends StatelessWidget {
  final int indice;

  /// Nulo em telas estreitas, onde so o numero da etapa aparece.
  final String? rotulo;
  final bool concluida;
  final bool ativa;
  final bool visitada;
  final VoidCallback onTap;

  const _Etapa({
    required this.indice,
    required this.rotulo,
    required this.concluida,
    required this.ativa,
    required this.visitada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final podeTocar = visitada && !ativa;

    return GestureDetector(
      onTap: podeTocar ? onTap : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: concluida ? WizardStepper.azul : Colors.white,
              border: concluida
                  ? null
                  : Border.all(
                      color: ativa
                          ? WizardStepper.azul
                          : visitada
                              ? WizardStepper.azul.withValues(alpha: 0.4)
                              : WizardStepper.linhaInativa,
                      width: ativa || visitada ? 2 : 1,
                    ),
            ),
            child: concluida
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(
                    '${indice + 1}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ativa || visitada
                          ? WizardStepper.azul
                          : WizardStepper.textoInativo,
                    ),
                  ),
          ),
          if (rotulo != null) ...[
            const SizedBox(height: 6),
            Text(
              rotulo!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: ativa ? FontWeight.w600 : FontWeight.w400,
                color: ativa
                    ? WizardStepper.azul
                    : concluida
                        ? const Color(0xFF09090B)
                        : visitada
                            ? WizardStepper.azul.withValues(alpha: 0.7)
                            : WizardStepper.textoInativo,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
