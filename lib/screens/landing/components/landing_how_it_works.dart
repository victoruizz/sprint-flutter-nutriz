import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';
import '../../../widgets/content_container.dart';
import 'section_label.dart';

/// Secao "Como funciona" (HowItWorksSection.tsx): cartao com a foto do banco
/// de leite, os tres passos e o bloco verde de contato pelo WhatsApp.
class LandingHowItWorks extends StatelessWidget {
  const LandingHowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.canvas,
      child: ContentContainer(
        espacoAcima: 40,
        espacoAbaixo: 56,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(texto: 'COMO FUNCIONA', cor: Color(0xFF0F9D8C)),
          const SizedBox(height: 12),
          const Text(
            'Tres passos para salvar uma vida',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.inkDeep,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Do cadastro a doacao, cuidamos de cada etapa com voce - simples, '
            'seguro e acolhedor.',
            style:
                TextStyle(fontSize: 15, color: AppColors.slate, height: 1.55),
          ),
          const SizedBox(height: 28),
          _cardBancoDeLeite(),
          const SizedBox(height: 16),
          ...passosLanding.map(
            (passo) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _CardPasso(passo: passo),
            ),
          ),
          _cardWhatsApp(context),
        ],
        ),
      ),
    );
  }

  Widget _cardBancoDeLeite() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/milk-bank.jpg',
            height: 260,
            width: double.infinity,
            fit: BoxFit.cover,
            semanticLabel:
                'Profissional de banco de leite processando leite humano doado',
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BANCO DE LEITE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.2,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cada gota e processada com seguranca',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWhatsApp(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FBF4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD7F0DE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/whatsapp-logo.png',
              height: 24, semanticLabel: 'WhatsApp'),
          const SizedBox(height: 12),
          const Text(
            'Fale com a nossa equipe',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.inkDeep,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tire duvidas e comece a sua triagem.',
            style: TextStyle(fontSize: 13, color: AppColors.slate),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: AppColors.white,
              minimumSize: const Size(0, 48),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Em breve: contato com a equipe Lactare pelo WhatsApp.',
                ),
              ),
            ),
            icon: const Icon(Icons.chat, size: 18),
            label: const Text(
              'Chamar no WhatsApp',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardPasso extends StatelessWidget {
  final PassoLanding passo;

  const _CardPasso({required this.passo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.hairline),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: passo.cor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  passo.numero,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(passo.icone, color: passo.cor, size: 28),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            passo.titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.inkDeep,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            passo.descricao,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.slate,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
