import 'package:flutter/material.dart';

/// Rotulo em caixa alta que abre cada secao da landing, como o
/// SectionLabel.tsx do web-nutriz: ponto colorido + texto espacado.
class SectionLabel extends StatelessWidget {
  final String texto;
  final Color cor;

  const SectionLabel({super.key, required this.texto, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          texto,
          style: TextStyle(
            color: cor,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}

/// Pilula com ponto pulsante usada no hero e no CTA final (ActivityBadge.tsx).
class ActivityBadge extends StatelessWidget {
  final String rotulo;
  final Color corPonto;

  const ActivityBadge({
    super.key,
    required this.rotulo,
    required this.corPonto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: corPonto, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            rotulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
