import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_doacoes.dart';
import '../../data/mock_usuaria.dart';
import '../../models/doacao.dart';
import '../../models/etapa_doacao.dart';
import '../../widgets/content_container.dart';
import '../donations/donation_detail_screen.dart';
import '../donations/new_donation_screen.dart';

/// Home da nutriz, seguindo pages/private/home do web-nutriz: bloco navy com
/// a saudacao e os dois botoes, a proxima etapa da doacao, o painel de
/// impacto com tres metricas e o acompanhamento da doacao em andamento.
class HomeScreen extends StatelessWidget {
  final void Function(int aba) onIrParaAba;
  final VoidCallback onAbrirEva;

  const HomeScreen({
    super.key,
    required this.onIrParaAba,
    required this.onAbrirEva,
  });

  static const Color _fundo = Color(0xFFF6F8FD);
  static const Color _titulo = Color(0xFF0E2A45);

  @override
  Widget build(BuildContext context) {
    final nutriz = usuariaMock;
    final Doacao ativa = doacoesMock.firstWhere(
      (d) => !d.concluida,
      orElse: () => doacoesMock.first,
    );

    return Container(
      color: _fundo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _hero(context, nutriz.primeiroNome, ativa),
          _secao(
            etiqueta: 'SEU IMPACTO',
            titulo: 'O que voce ja realizou',
            descricao:
                'Veja o impacto da sua generosidade. Cada doacao sua '
                'transforma a vida de um bebe prematuro.',
            filho: _metricas(nutriz.leiteDoadoMl),
          ),
          _secao(
            etiqueta: 'STATUS',
            titulo: 'Acompanhe sua doacao',
            filho: _cardStatus(context, ativa),
          ),
          _secao(
            etiqueta: 'REDE DE APOIO',
            titulo: 'Historias que o seu leite escreve',
            filho: _cardHistoria(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context, String primeiroNome, Doacao ativa) {
    return Container(
      width: double.infinity,
      color: AppColors.heroNavy,
      child: ContentContainer(
        larguraMaxima: 1100,
        espacoAcima: 28,
        espacoAbaixo: 40,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final emLinha = constraints.maxWidth >= 860;

            final saudacao = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ola, $primeiroNome!',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        foregroundColor: AppColors.navy,
                        minimumSize: const Size(0, 52),
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewDonationScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text(
                        'Nova Doacao',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(0, 52),
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        side: const BorderSide(
                            color: AppColors.white, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: onAbrirEva,
                      child: const Text(
                        'Falar com a EVA',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            );

            final proxima = _CardProximaEtapa(
              doacao: ativa,
              onConsultar: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DonationDetailScreen(doacao: ativa),
                ),
              ),
            );

            if (emLinha) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: saudacao),
                  const SizedBox(width: 40),
                  SizedBox(width: 360, child: proxima),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                saudacao,
                const SizedBox(height: 24),
                proxima,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _secao({
    required String etiqueta,
    required String titulo,
    String? descricao,
    required Widget filho,
  }) {
    return ContentContainer(
      larguraMaxima: 1100,
      espacoAcima: 36,
      // Sem a largura cheia o Column encolhe ate o maior filho e o
      // ContentContainer centraliza a secao inteira.
      child: SizedBox(
        width: double.infinity,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            etiqueta,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.12,
              color: AppColors.teal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
              color: _titulo,
            ),
          ),
          if (descricao != null) ...[
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                descricao,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF3F3F46),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          filho,
        ],
        ),
      ),
    );
  }

  Widget _metricas(double leiteMl) {
    final doacoesFeitas = doacoesMock.where((d) => d.concluida).length;
    final litros = (leiteMl / 1000).toStringAsFixed(2).replaceAll('.', ',');
    final bebes = (leiteMl / 200).floor();

    final cartoes = [
      _Metrica(
        icone: Icons.card_giftcard,
        cor: AppColors.navy,
        fundo: const Color(0xFFE6F1FB),
        valor: '$doacoesFeitas',
        rotulo: 'Doacoes realizadas',
        subRotulo: 'Desde janeiro de 2026',
      ),
      _Metrica(
        icone: Icons.water_drop_outlined,
        cor: AppColors.teal,
        fundo: const Color(0xFFE1F5EE),
        valor: '$litros L',
        rotulo: 'Leite doado',
        subRotulo: '${leiteMl.toInt()} ml no total',
      ),
      _Metrica(
        icone: Icons.favorite,
        cor: AppColors.pink,
        fundo: const Color(0xFFFBEAF0),
        valor: '$bebes',
        rotulo: 'Bebes alimentados',
        subRotulo: 'Estimativa rBLH (~200 ml/bebe.dia)',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 760) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < cartoes.length; i++) ...[
                if (i > 0) const SizedBox(width: 20),
                Expanded(child: cartoes[i]),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (final c in cartoes)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: c,
              ),
          ],
        );
      },
    );
  }

  Widget _cardStatus(BuildContext context, Doacao doacao) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    doacao.id,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _titulo,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DonationDetailScreen(doacao: doacao),
                    ),
                  ),
                  child: const Text('Ver detalhes'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...doacao.etapas.take(4).map(
                  (etapa) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          etapa.status == StatusEtapa.concluida
                              ? Icons.check_circle
                              : etapa.status == StatusEtapa.emAndamento
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                          size: 20,
                          color: etapa.status == StatusEtapa.concluida
                              ? AppColors.teal
                              : etapa.status == StatusEtapa.emAndamento
                                  ? AppColors.blue
                                  : AppColors.line,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            etapa.titulo,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: etapa.status == StatusEtapa.emAndamento
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _cardHistoria() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.hairline),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote, color: AppColors.pink, size: 26),
            SizedBox(height: 8),
            Text(
              'Achei que seria complicado, mas a equipe do Nutriz me guiou em '
              'cada etapa. Saber que meu leite alimentou um bebe na UTI me '
              'encheu de proposito.',
              style: TextStyle(fontSize: 14.5, height: 1.6, color: Color(0xFF3F3F46)),
            ),
            SizedBox(height: 12),
            Text(
              'Ana Paula S. - doadora ha 8 meses',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardProximaEtapa extends StatelessWidget {
  final Doacao doacao;
  final VoidCallback onConsultar;

  const _CardProximaEtapa({required this.doacao, required this.onConsultar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROXIMA ETAPA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: AppColors.teal,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            doacao.statusAtual,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: HomeScreen._titulo,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${doacao.etapasConcluidas} de ${doacao.etapas.length} etapas '
            'concluidas',
            style: const TextStyle(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: doacao.progresso,
              minHeight: 6,
              backgroundColor: AppColors.line,
              valueColor: const AlwaysStoppedAnimation(AppColors.teal),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: AppColors.white,
                minimumSize: const Size(0, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: onConsultar,
              child: const Text(
                'Consultar',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metrica extends StatelessWidget {
  final IconData icone;
  final Color cor;
  final Color fundo;
  final String valor;
  final String rotulo;
  final String subRotulo;

  const _Metrica({
    required this.icone,
    required this.cor,
    required this.fundo,
    required this.valor,
    required this.rotulo,
    required this.subRotulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: fundo,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icone, color: cor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valor,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: cor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  rotulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkDeep,
                  ),
                ),
                Text(
                  subRotulo,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.slateLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
