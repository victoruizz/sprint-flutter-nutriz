import 'package:flutter/material.dart';

import '../../../core/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';
import '../../../widgets/nutriz_logo.dart';

/// Rodape da landing (LandingFooter.tsx): wordmark + assinatura da Lactare,
/// redes sociais, colunas de links e a linha de creditos rBLH/Fiocruz.
class LandingFooter extends StatelessWidget {
  final void Function(String secao) onIrParaSecao;

  const LandingFooter({super.key, required this.onIrParaSecao});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.footerNavy,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const NutrizLogo(altura: 26),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  'por Lactare',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onNavyMuted.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Conectamos doadoras de leite humano aos bancos de leite para dar '
            'a bebes prematuros a chance de crescer com saude.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.onNavyMuted,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              _BotaoSocial(
                  icone: Icons.camera_alt_outlined, rotulo: 'Instagram'),
              SizedBox(width: 10),
              _BotaoSocial(icone: Icons.facebook, rotulo: 'Facebook'),
              SizedBox(width: 10),
              _BotaoSocial(
                  icone: Icons.play_circle_outline, rotulo: 'YouTube'),
              SizedBox(width: 10),
              _BotaoSocial(icone: Icons.work_outline, rotulo: 'LinkedIn'),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: colunasRodape
                .map(
                  (coluna) => Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coluna.titulo,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...coluna.links.map(
                          (link) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () {
                                if (link == 'Entrar') {
                                  Navigator.pushNamed(
                                      context, AppRoutes.login);
                                } else {
                                  onIrParaSecao(link);
                                }
                              },
                              child: Text(
                                link,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.onNavyMuted,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          Divider(color: AppColors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          const Text(
            '(c) 2026 Nutriz por Lactare',
            style: TextStyle(fontSize: 13, color: AppColors.onNavyMuted),
          ),
          const SizedBox(height: 6),
          const Text(
            'Conteudo educativo validado por rBLH e Fiocruz',
            style: TextStyle(fontSize: 13, color: AppColors.onNavyMuted),
          ),
        ],
      ),
    );
  }
}

class _BotaoSocial extends StatelessWidget {
  final IconData icone;
  final String rotulo;

  const _BotaoSocial({required this.icone, required this.rotulo});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Nutriz no $rotulo',
      button: true,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icone, size: 18, color: AppColors.white),
      ),
    );
  }
}
