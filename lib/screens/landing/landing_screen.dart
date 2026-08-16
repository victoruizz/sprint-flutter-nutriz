import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_landing.dart';
import '../../widgets/content_container.dart';
import '../../widgets/eva_fab.dart';
import '../../widgets/nutriz_logo.dart';
import '../eva/eva_chat_screen.dart';
import 'components/landing_articles.dart';
import 'components/landing_cta.dart';
import 'components/landing_eva.dart';
import 'components/landing_footer.dart';
import 'components/landing_hero.dart';
import 'components/landing_how_it_works.dart';
import 'components/landing_points.dart';
import 'components/landing_stats.dart';
import 'components/landing_testimonials.dart';

/// Landing page publica do Nutriz, na mesma ordem de secoes do web-nutriz
/// (pages/public/landing-page/index.tsx): hero, metricas, como funciona,
/// pontos de coleta, EVA, artigos, depoimentos, CTA final e rodape.
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _scrollController = ScrollController();

  // Ancoras usadas pelo menu e pelo rodape para rolar ate cada secao.
  final _chaves = <String, GlobalKey>{
    'Como funciona': GlobalKey(),
    'Pontos de coleta': GlobalKey(),
    'A EVA': GlobalKey(),
    'Artigos': GlobalKey(),
    'Depoimentos': GlobalKey(),
  };

  bool _rolou = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final rolou = _scrollController.offset > 16;
      if (rolou != _rolou) setState(() => _rolou = rolou);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _irParaSecao(String secao) {
    final chave = _chaves[secao];
    final contexto = chave?.currentContext;
    if (contexto == null) return;

    Scrollable.ensureVisible(
      contexto,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  void _abrirEva([String? sugestao]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EvaChatScreen(perguntaInicial: sugestao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      endDrawer: _MenuLanding(
        onIrParaSecao: _irParaSecao,
        secoes: secoesLanding,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                LandingHero(
                  onSaibaMais: () => _irParaSecao('Como funciona'),
                ),
                const LandingStats(),
                Container(
                  key: _chaves['Como funciona'],
                  child: const LandingHowItWorks(),
                ),
                Container(
                  key: _chaves['Pontos de coleta'],
                  child: const LandingPoints(),
                ),
                Container(
                  key: _chaves['A EVA'],
                  child: LandingEva(onAbrirEva: _abrirEva),
                ),
                Container(
                  key: _chaves['Artigos'],
                  child: const LandingArticles(),
                ),
                Container(
                  key: _chaves['Depoimentos'],
                  child: const LandingTestimonials(),
                ),
                const LandingCta(),
                LandingFooter(onIrParaSecao: _irParaSecao),
              ],
            ),
          ),
          _header(),
          // FAB da EVA, presente em todas as telas do produto real.
          Positioned(
            right: 20,
            bottom: 20,
            child: EvaFab(onPressed: _abrirEva),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    final larguraTela = MediaQuery.sizeOf(context).width;
    final recuo = larguraTela >= 1024 ? 32.0 : 20.0;
    // Largura explicita: dentro de um Positioned o Row nao recebia largura
    // definida, entao Spacer/spaceBetween nao tinham espaco para distribuir e
    // tudo ficava amontoado a esquerda.
    final larguraConteudo =
        math.min(larguraTela - recuo * 2, ContentContainer.larguraPadrao);

    // No site a navegacao completa aparece a partir de lg e o botao de menu
    // fica escondido (`lg:hidden`).
    final navCompleta = larguraTela >= 1100;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _rolou ? AppColors.heroNavy : Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: Center(
            child: SizedBox(
              width: larguraConteudo,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const NutrizLogo(altura: 24),
                    if (navCompleta)
                      // Encolhe e rola caso a pilula nao caiba, em vez de
                      // estourar a linha e cortar os botoes da direita.
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _navSecoes(),
                        ),
                      ),
                    if (navCompleta)
                      _acoesEntrada(context)
                    else
                      _botaoMenu(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Pilula com os links das secoes, como a `nav` do LandingHeader.tsx.
  Widget _navSecoes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: secoesLanding
            .map(
              (secao) => _LinkSecao(
                rotulo: secao.rotulo,
                onTap: () => _irParaSecao(secao.rotulo),
              ),
            )
            .toList(),
      ),
    );
  }

  /// Login e Cadastrar-se, os dois botoes a direita do header no site.
  Widget _acoesEntrada(BuildContext context) {
    // Os botoes sao dimensionados pelo proprio estilo. Envolve-los num
    // SizedBox so com altura faz cada um reportar largura ilimitada dentro do
    // Row, o que comia todo o espaco do header e cortava o Cadastrar-se.
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.white.withValues(alpha: 0.1),
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              side: BorderSide(color: AppColors.white.withValues(alpha: 0.15)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        const SizedBox(width: 8),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.heroNavy,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
            child: const Text(
              'Cadastrar-se',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }

  Widget _botaoMenu() {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.withValues(alpha: 0.15)),
        ),
        child: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.white, size: 24),
          tooltip: 'Abrir menu',
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ),
    );
  }
}

/// Link de secao do header, com realce ao passar o mouse como no site.
class _LinkSecao extends StatefulWidget {
  final String rotulo;
  final VoidCallback onTap;

  const _LinkSecao({required this.rotulo, required this.onTap});

  @override
  State<_LinkSecao> createState() => _LinkSecaoState();
}

class _LinkSecaoState extends State<_LinkSecao> {
  bool _sobre = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _sobre = true),
      onExit: (_) => setState(() => _sobre = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _sobre
                ? AppColors.white.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            widget.rotulo,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _sobre ? AppColors.white : AppColors.onNavy,
            ),
          ),
        ),
      ),
    );
  }
}

/// Menu lateral da landing, espelhando o Sheet do LandingHeader.tsx.
class _MenuLanding extends StatelessWidget {
  final void Function(String secao) onIrParaSecao;
  final List<SecaoLanding> secoes;

  const _MenuLanding({required this.onIrParaSecao, required this.secoes});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.drawerBlue,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NutrizLogo(altura: 28),
                      const SizedBox(height: 8),
                      Text(
                        'Doe leite. Multiplique vidas.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: IconButton(
                      icon: Icon(Icons.close,
                          color: AppColors.white.withValues(alpha: 0.8),
                          size: 20),
                      tooltip: 'Fechar menu',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: secoes
                  .map(
                    (secao) => InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onIrParaSecao(secao.rotulo);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            Icon(secao.icone,
                                size: 20, color: const Color(0xFF334155)),
                            const SizedBox(width: 16),
                            Text(
                              secao.rotulo,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF334155),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.line),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.drawerBlue,
                        minimumSize: const Size(0, 44),
                        side: const BorderSide(color: Color(0xFFD0D9E8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.drawerBlue,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
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
