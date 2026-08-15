import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_eva.dart';
import '../../models/mensagem_eva.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/suggestion_chip.dart';

class EvaChatScreen extends StatefulWidget {
  /// Pergunta enviada automaticamente ao abrir o chat. E o que acontece no
  /// produto real quando a nutriz toca num chip de sugestao da landing:
  /// o texto ja entra como primeira mensagem dela.
  final String? perguntaInicial;

  const EvaChatScreen({super.key, this.perguntaInicial});

  @override
  State<EvaChatScreen> createState() => _EvaChatScreenState();
}

class _EvaChatScreenState extends State<EvaChatScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('EVA')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.pinkSoft,
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 18, color: AppColors.pink),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    evaAvisoMedico,
                    style: TextStyle(
                        fontSize: 12, color: AppColors.ink, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
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
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.send, color: AppColors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
