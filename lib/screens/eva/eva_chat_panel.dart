import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_eva.dart';
import '../../models/mensagem_eva.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/suggestion_chip.dart';

/// Conteudo da conversa com a EVA, sem casca de tela: cabecalho com o avatar,
/// aviso de que a EVA nao substitui avaliacao medica, historico, chips de
/// sugestao e campo de envio.
///
/// E usado dentro do widget flutuante (EvaWidget), como no produto real, onde
/// a EVA e um painel no canto da tela e nao uma pagina.
class EvaChatPanel extends StatefulWidget {
  /// Pergunta enviada automaticamente ao abrir, usada pelos chips da landing.
  final String? perguntaInicial;

  /// Fecha o painel. Quando nulo, o cabecalho nao mostra o botao de fechar.
  final VoidCallback? onFechar;

  const EvaChatPanel({super.key, this.perguntaInicial, this.onFechar});

  @override
  State<EvaChatPanel> createState() => _EvaChatPanelState();
}

class _EvaChatPanelState extends State<EvaChatPanel> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final List<MensagemEva> _mensagens = [
    const MensagemEva(texto: evaSaudacao, daEva: true),
  ];
  bool _digitando = false;

  @override
  void initState() {
    super.initState();
    final pergunta = widget.perguntaInicial;
    if (pergunta != null && pergunta.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _enviar(pergunta));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _rolarParaFim() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _enviar(String texto) async {
    final t = texto.trim();
    if (t.isEmpty) return;
    setState(() {
      _mensagens.add(MensagemEva(texto: t, daEva: false));
      _controller.clear();
      _digitando = true;
    });
    _rolarParaFim();
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() {
      _digitando = false;
      _mensagens.add(MensagemEva(texto: respostaEva(t), daEva: true));
    });
    _rolarParaFim();
  }

  @override
  Widget build(BuildContext context) {
    final mostrarSugestoes = _mensagens.length <= 1 && !_digitando;

    return Column(
      children: [
        _cabecalho(),
        _aviso(),
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              for (final m in _mensagens) ChatBubble(mensagem: m),
              if (_digitando) _digitandoBolha(),
            ],
          ),
        ),
        if (mostrarSugestoes)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final s in evaSugestoes)
                  SuggestionChip(texto: s, onTap: () => _enviar(s)),
              ],
            ),
          ),
        _barraEntrada(),
      ],
    );
  }

  /// Cabecalho branco com o avatar em gradiente e o estado "online", como no
  /// eva-widget-header do site.
  Widget _cabecalho() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0EDF2))),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF7CCA0),
                  Color(0xFFF0A0BE),
                  Color(0xFFB79CE0),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EVA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1B1F),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PontoOnline(),
                  SizedBox(width: 5),
                  Text(
                    'online',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF227A52),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (widget.onFechar != null)
            IconButton(
              icon: const Icon(Icons.close, size: 20, color: AppColors.muted),
              tooltip: 'Fechar',
              onPressed: widget.onFechar,
            ),
        ],
      ),
    );
  }

  Widget _aviso() {
    return Container(
      width: double.infinity,
      color: AppColors.pinkSoft,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: const Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.pink),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              evaAvisoMedico,
              style:
                  TextStyle(fontSize: 11.5, color: AppColors.ink, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _digitandoBolha() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.teal),
            ),
            SizedBox(width: 8),
            Text(
              'EVA esta digitando...',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barraEntrada() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: _enviar,
                decoration: const InputDecoration(
                  hintText: 'Escreva uma mensagem...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Material(
              color: AppColors.navy,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _enviar(_controller.text),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.send, color: AppColors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PontoOnline extends StatelessWidget {
  const _PontoOnline();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Color(0xFF2EA36A),
        shape: BoxShape.circle,
      ),
    );
  }
}
