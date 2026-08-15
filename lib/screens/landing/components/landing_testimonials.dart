import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_landing.dart';
import 'section_label.dart';

/// Secao de depoimentos (TestimonialsSection.tsx): carrossel com setas e
/// indicadores, um depoimento por vez.
class LandingTestimonials extends StatefulWidget {
  const LandingTestimonials({super.key});

  @override
  State<LandingTestimonials> createState() => _LandingTestimonialsState();
}

class _LandingTestimonialsState extends State<LandingTestimonials> {
  int _indice = 0;

  void _ir(int proximo) {
    final total = depoimentosLanding.length;
    setState(() => _indice = (proximo + total) % total);
  }

  @override
  Widget build(BuildContext context) {
    final depoimento = depoimentosLanding[_indice];

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 56),
      child: Column(
        children: [
          const SectionLabel(texto: 'DEPOIMENTOS', cor: AppColors.blue),
          const SizedBox(height: 12),
          const Text(
            'Quem ja doou conta',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.inkDeep,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _seta(Icons.chevron_left, 'Depoimento anterior',
                  () => _ir(_indice - 1)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _CardDepoimento(depoimento: depoimento),
                ),
              ),
              _seta(Icons.chevron_right, 'Proximo depoimento',
                  () => _ir(_indice + 1)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              depoimentosLanding.length,
              (i) => GestureDetector(
                onTap: () => setState(() => _indice = i),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _indice ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        i == _indice ? AppColors.blue : const Color(0xFFCDD8EA),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seta(IconData icone, String tooltip, VoidCallback onTap) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.hairline),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icone, size: 20, color: AppColors.blue),
        tooltip: tooltip,
        onPressed: onTap,
      ),
    );
  }
}

class _CardDepoimento extends StatelessWidget {
  final DepoimentoLanding depoimento;

  const _CardDepoimento({required this.depoimento});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: AppColors.blue, size: 28),
          const SizedBox(height: 12),
          Text(
            depoimento.texto,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.inkDeep,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.blueSoft,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  depoimento.nome[0],
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    depoimento.nome,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.inkDeep,
                    ),
                  ),
                  Text(
                    depoimento.desde,
                    style: const TextStyle(
                        fontSize: 12.5, color: AppColors.slate),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
