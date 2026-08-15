import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_doacoes.dart';
import '../../data/mock_usuaria.dart';
import '../../models/doacao.dart';
import '../../widgets/section_card.dart';
import '../donations/donation_detail_screen.dart';

/// Aba inicial: saudacao personalizada, doacao em andamento, atalhos e a EVA.
class HomeScreen extends StatelessWidget {
  final void Function(int aba) onIrParaAba;
  final VoidCallback onAbrirEva;

  const HomeScreen({
    super.key,
    required this.onIrParaAba,
    required this.onAbrirEva,
  });

  @override
  Widget build(BuildContext context) {
    final nutriz = usuariaMock;
    final Doacao ativa = doacoesMock.firstWhere(
      (d) => !d.concluida,
      orElse: () => doacoesMock.first,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Nutriz')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Ola, ${nutriz.primeiroNome}!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Obrigada por doar. Voce ja doou ${nutriz.leiteDoadoMl.toInt()} ml de leite.',
            style: const TextStyle(color: AppColors.muted, height: 1.35),
          ),
          const SizedBox(height: AppSpacing.lg),
          _tituloSecao('Sua doacao em andamento'),
          SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DonationDetailScreen(doacao: ativa),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ativa.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.muted),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Etapa atual: ${ativa.statusAtual}',
                  style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: ativa.progresso,
                    minHeight: 8,
                    backgroundColor: AppColors.line,
                    valueColor: const AlwaysStoppedAnimation(AppColors.teal),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${ativa.etapasConcluidas} de ${ativa.etapas.length} etapas concluidas',
                  style: const TextStyle(color: AppColors.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _tituloSecao('Atalhos'),
          Row(
            children: [
              _Atalho(
                icone: Icons.favorite,
                cor: AppColors.pink,
                fundo: AppColors.pinkSoft,
                label: 'Doacoes',
                onTap: () => onIrParaAba(1),
              ),
              const SizedBox(width: AppSpacing.sm),
              _Atalho(
                icone: Icons.place,
                cor: AppColors.navy,
                fundo: AppColors.blueSoft,
                label: 'Pontos',
                onTap: () => onIrParaAba(2),
              ),
              const SizedBox(width: AppSpacing.sm),
              _Atalho(
                icone: Icons.menu_book,
                cor: AppColors.teal,
                fundo: AppColors.tealSoft,
                label: 'Conteudo',
                onTap: () => onIrParaAba(3),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionCard(
            onTap: onAbrirEva,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    gradient: AppColors.evaGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chat_bubble_outline, color: AppColors.white),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Converse com a EVA',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.ink),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Tire duvidas sobre doacao, ordenha e amamentacao.',
                        style: TextStyle(color: AppColors.muted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.muted),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _tituloSecao('Dica de armazenamento'),
          const SectionCard(
            child: Row(
              children: [
                Icon(Icons.ac_unit, color: AppColors.teal),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Congele o leite logo apos a ordenha e anote a data e a hora '
                    'na tampa - o leite cru congelado vale ate 15 dias.',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 13.5,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tituloSecao(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      );
}

/// Cartao de atalho quadrado usado na home.
class _Atalho extends StatelessWidget {
  final IconData icone;
  final Color cor;
  final Color fundo;
  final String label;
  final VoidCallback onTap;

  const _Atalho({
    required this.icone,
    required this.cor,
    required this.fundo,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SectionCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: fundo, shape: BoxShape.circle),
              child: Icon(icone, color: cor),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
