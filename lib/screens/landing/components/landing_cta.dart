import 'package:flutter/material.dart';

import '../../../core/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';
import '../../../widgets/content_container.dart';
import 'section_label.dart';

/// CTA final da landing (FinalCtaSection.tsx): cartao navy com os dois
/// caminhos - cadastro e login - e a prova social das doadoras.
class LandingCta extends StatelessWidget {
  const LandingCta({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.canvas,
      child: ContentContainer(
        espacoAcima: 48,
        espacoAbaixo: 56,
        child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: AppColors.heroNavy.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.heroNavy,
            borderRadius: BorderRadius.circular(26),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // `lg:flex-row lg:items-center lg:justify-between`: chamada a
              // esquerda, botoes e prova social a direita.
              final ladoALado = constraints.maxWidth >= 860;

              if (ladoALado) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _chamada()),
                    const SizedBox(width: 48),
                    _acoes(context, alinharADireita: true),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _chamada(),
                  const SizedBox(height: 28),
                  _acoes(context, alinharADireita: false),
                ],
              );
            },
          ),
        ),
        ),
      ),
    );
  }

  Widget _chamada() {
    return const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivityBadge(
                rotulo: 'Junte-se a nos',
                corPonto: AppColors.cyan,
              ),
              SizedBox(height: 20),
              Text(
                'Pronta para fazer a diferenca?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Cadastre-se agora e comece sua jornada de doacao.',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.onNavy,
                  height: 1.55,
                ),
              ),
      ],
    );
  }

  Widget _acoes(BuildContext context, {required bool alinharADireita}) {
    return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: alinharADireita
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // `flex-col sm:flex-row`: os dois botoes ficam um ao lado do
              // outro assim que ha espaco.
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment:
                    alinharADireita ? WrapAlignment.end : WrapAlignment.start,
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
                      'Quero ser doadora',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(0, 48),
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      side: BorderSide(
                          color: AppColors.white.withValues(alpha: 0.4)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.login),
                    child: const Text(
                      'Ja sou doadora - fazer login',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 24.0 * avatarsCta.length + 8,
                    height: 32,
                    child: Stack(
                      children: [
                        for (var i = 0; i < avatarsCta.length; i++)
                          Positioned(
                            left: i * 24.0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: avatarsCta[i],
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontSize: 13, color: AppColors.onNavy),
                        children: [
                          TextSpan(
                            text: '4.200+ ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(text: 'doadoras ja fazem parte'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
    );
  }
}
