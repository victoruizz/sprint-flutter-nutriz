import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';

/// Secao da EVA (EvaSection.tsx): bloco com o gradiente pastel da marca,
/// previa da conversa e chips de sugestao que abrem o chat.
class LandingEva extends StatelessWidget {
  final void Function(String? sugestao) onAbrirEva;

  const LandingEva({super.key, required this.onAbrirEva});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 64,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.fromLTRB(28, 40, 28, 40),
            decoration: BoxDecoration(
              gradient: evaLandingGradient,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Ponto(cor: Color(0xFF2EA36A)),
                      SizedBox(width: 8),
                      Text(
                        'ASSISTENTE 24 HORAS',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                          color: Color(0xFFA52D5E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Como voce esta hoje?',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                    letterSpacing: -0.7,
                    color: Color(0xFF1C1B1F),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'A EVA acolhe voce a qualquer hora - doacao de leite, '
                  'ordenha, armazenamento e amamentacao. Sem fila, sem espera.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(0xFF3D3543),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: const Color(0xFF1C1B1F),
                    minimumSize: const Size(0, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () => onAbrirEva(null),
                  child: const Text(
                    'Falar com a EVA',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 28),
                _previaConversa(),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Comece por aqui:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1B1F),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sugestoesEva
                .map(
                  (s) => GestureDetector(
                    onTap: () => onAbrirEva(s),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 44),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE7EF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        s,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB8386A),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _previaConversa() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3C1E46).withValues(alpha: 0.28),
            blurRadius: 60,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF7CCA0),
                      Color(0xFFF0A0BE),
                      Color(0xFFB79CE0),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'EVA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1B1F),
                ),
              ),
              const SizedBox(width: 10),
              const _Ponto(cor: Color(0xFF2EA36A)),
              const SizedBox(width: 6),
              const Text(
                'online',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF227A52),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFCE0C6),
                    Color(0xFFF6C4D4),
                    Color(0xFFF2BCCF),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: const Text(
                'Meu bebe tem 4 meses, ainda posso doar?',
                style: TextStyle(
                    fontSize: 14, height: 1.35, color: Color(0xFF1C1B1F)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F0F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'Pode sim! Enquanto voce amamenta e tem leite de sobra, sua '
                'doacao e muito bem-vinda.',
                style: TextStyle(
                    fontSize: 14, height: 1.35, color: Color(0xFF1C1B1F)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ponto extends StatelessWidget {
  final Color cor;

  const _Ponto({required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
    );
  }
}
