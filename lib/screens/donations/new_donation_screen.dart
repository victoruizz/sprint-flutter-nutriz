import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/app_page.dart';

/// Inicio de uma nova doacao, seguindo pages/private/donations/common/create
/// do web-nutriz: a nutriz confirma o interesse, e a partir dai a equipe
/// Lactare assume a triagem e o agendamento.
class NewDonationScreen extends StatefulWidget {
  const NewDonationScreen({super.key});

  @override
  State<NewDonationScreen> createState() => _NewDonationScreenState();
}

class _NewDonationScreenState extends State<NewDonationScreen> {
  static const Color _titulo = Color(0xFF0E2A45);

  bool _confirmando = false;

  Future<void> _confirmar() async {
    setState(() => _confirmando = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _confirmando = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Doacao iniciada! A equipe Lactare vai continuar pelo WhatsApp.',
        ),
        backgroundColor: AppColors.teal,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      titulo: 'Nova doacao',
      larguraMaxima: 900,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0A2957).withValues(alpha: 0.07),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'O que vai acontecer',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _titulo,
                  ),
                ),
                const SizedBox(height: 20),
                const _Passo(
                  titulo: 'Confirmacao',
                  texto: 'Voce confirma o interesse em fazer uma nova doacao',
                  icone: Icons.favorite,
                  cor: AppColors.pink,
                  fundo: Color(0xFFFBEAF0),
                ),
                const _Passo(
                  titulo: 'Redirecionamento',
                  texto:
                      'Voce e redirecionada para o WhatsApp da equipe Lactare',
                  icone: Icons.chat,
                  cor: AppColors.white,
                  fundo: Color(0xFF25D366),
                ),
                const _Passo(
                  titulo: 'Triagem e agendamento',
                  texto: 'A equipe realiza a triagem inicial e agenda a coleta',
                  icone: Icons.check,
                  cor: AppColors.navy,
                  fundo: Color(0xFFDBE7F6),
                ),
                const _Passo(
                  titulo: 'Acompanhamento',
                  texto:
                      'Sua doacao e registrada e acompanhada aqui no sistema',
                  icone: Icons.water_drop,
                  cor: AppColors.pink,
                  fundo: Color(0xFFFBEAF0),
                  ultima: true,
                ),
                const SizedBox(height: 20),
                _aviso(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _confirmando ? null : _confirmar,
              child: _confirmando
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Confirmando...'),
                      ],
                    )
                  : const Text(
                      'Confirmar',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF9AA8BC),
              ),
              onPressed: _confirmando ? null : () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aviso() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF5E3B3)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 18, color: Color(0xFF9A6B00)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'A doacao so e confirmada apos a triagem da equipe Lactare. '
              'Mantenha o leite congelado ate a coleta.',
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Color(0xFF7A5600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Passo extends StatelessWidget {
  final String titulo;
  final String texto;
  final IconData icone;
  final Color cor;
  final Color fundo;
  final bool ultima;

  const _Passo({
    required this.titulo,
    required this.texto,
    required this.icone,
    required this.cor,
    required this.fundo,
    this.ultima = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: fundo, shape: BoxShape.circle),
                child: Icon(icone, size: 20, color: cor),
              ),
              if (!ultima)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE5EBF3)),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: ultima ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0E2A45),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    texto,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.45,
                      color: AppColors.slate,
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
}
