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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ActivityBadge(
                rotulo: 'Junte-se a nos',
                corPonto: AppColors.cyan,
              ),
              const SizedBox(height: 20),
              const Text(
                'Pronta para fazer a diferenca?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Cadastre-se agora e comece sua jornada de doacao.',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.onNavy,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.heroNavy,
                    minimumSize: const Size(0, 48),
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
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(0, 48),
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
              ),
              const SizedBox(height: 24),
              Row(
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
                  const Expanded(
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
          ),
        ),
        ),
      ),
    );
  }
}
