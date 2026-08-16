import 'package:flutter/material.dart';

import '../../../core/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/content_container.dart';
import 'section_label.dart';

/// Hero da landing (HeroSection.tsx): fundo navy, badge, titulo em duas
/// linhas com "Multiplica Vidas." em ciano, subtitulo e dois CTAs.
class LandingHero extends StatelessWidget {
  final VoidCallback onSaibaMais;

  const LandingHero({super.key, required this.onSaibaMais});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.heroNavy,
      child: Stack(
        children: [
          // Halos difusos do HeroBackground.tsx.
          Positioned(
            top: -60,
            left: -40,
            child: _halo(220, AppColors.cyanDeep.withValues(alpha: 0.18)),
          ),
          Positioned(
            bottom: -80,
            right: -60,
            child: _halo(260, const Color(0xFF4F8FF0).withValues(alpha: 0.22)),
          ),
          ContentContainer(
            espacoAcima: 96,
            espacoAbaixo: 56,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // No site o hero e `lg:grid-cols-2`: texto a esquerda e a
                // imagem a direita. Abaixo disso os dois empilham.
                final duasColunas = constraints.maxWidth >= 900;

                if (duasColunas) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _conteudo(context)),
                      const SizedBox(width: 40),
                      Expanded(child: _imagem(maxLargura: 512)),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _conteudo(context),
                    const SizedBox(height: 32),
                    _imagem(maxLargura: 448),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagem({required double maxLargura}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxLargura),
        child: Image.asset(
          'assets/images/hero-mother-baby.png',
          fit: BoxFit.contain,
          semanticLabel: 'Mae amamentando seu bebe',
        ),
      ),
    );
  }

  Widget _conteudo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                const ActivityBadge(
                  rotulo: 'Faca sua doacao',
                  corPonto: AppColors.cyan,
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      height: 1.08,
                      letterSpacing: -0.5,
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(text: 'Doar Amor.\n'),
                      TextSpan(
                        text: 'Multiplica Vidas.',
                        style: TextStyle(color: AppColors.cyan),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: const Text(
                    'Uma gota do seu leite pode ser tudo que um bebe prematuro '
                    'precisa para sobreviver.',
                    style: TextStyle(
                      color: AppColors.onNavy,
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.heroNavy,
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text(
                        'Quero doar',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        side: BorderSide(
                            color: AppColors.white.withValues(alpha: 0.4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: onSaibaMais,
                      child: const Text(
                        'Saiba mais',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ],
                ),
      ],
    );
  }

  Widget _halo(double tamanho, Color cor) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [cor, cor.withValues(alpha: 0)]),
      ),
    );
  }
}
