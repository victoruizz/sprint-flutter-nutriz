import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../models/agendamento.dart';
import '../../widgets/agendamento_status_chip.dart';
import '../../widgets/app_page.dart';

/// Detalhe do agendamento na visao da enfermagem, seguindo
/// pages/private/job/detail do web-nutriz.
///
/// E aqui que a enfermagem trabalha: ve o resumo da visita e a orientacao da
/// etapa e, enquanto o agendamento esta em aberto, **atualiza o status**
/// (realizada ou nao realizada) e **registra o relatorio**. Agendamentos ja
/// encerrados ficam em somente leitura, com o resultado e o historico.
class AppointmentDetailScreen extends StatefulWidget {
  final Agendamento agendamento;

  const AppointmentDetailScreen({super.key, required this.agendamento});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF9CA3AF);
  static const Color _borda = Color(0xFFE7ECF2);

  final _relatorio = TextEditingController();

  late Agendamento _agendamento = widget.agendamento;
  StatusAgendamento _statusEscolhido = StatusAgendamento.realizada;
  bool _salvando = false;

  @override
  void dispose() {
    _relatorio.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_relatorio.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escreva o relatorio antes de salvar.'),
        ),
      );
      return;
    }

    setState(() => _salvando = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    setState(() {
      _salvando = false;
      _agendamento = _agendamento.copyWith(
        status: _statusEscolhido,
        relatorios: [
          ..._agendamento.relatorios,
          RelatorioAgendamento(
            etapa: _agendamento.etapa,
            data: DateTime.now(),
            texto: _relatorio.text.trim(),
            resultado: _statusEscolhido,
          ),
        ],
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Status atualizado com sucesso.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a = _agendamento;

    return AppPage(
      titulo: 'Agendamento ${a.id}',
      larguraMaxima: 1200,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Text(
            'Acompanhe cada etapa do processo do agendamento.',
            style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final emLinha = constraints.maxWidth >= 900;
              final resumo = _cardResumo(a);
              final acoes = _colunaAcoes(a);

              if (emLinha) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 340, child: resumo),
                    const SizedBox(width: 24),
                    Expanded(child: acoes),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [resumo, const SizedBox(height: 20), acoes],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _cardResumo(Agendamento a) {
    return _cartao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.blueSoft,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  a.doadora
                      .split(' ')
                      .take(2)
                      .map((p) => p[0])
                      .join()
                      .toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A77B0),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.doadora,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _tinta,
                      ),
                    ),
                    const Text(
                      'Doadora',
                      style: TextStyle(fontSize: 13, color: _cinza),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: _borda),
          const SizedBox(height: 16),
          _info(Icons.calendar_today_outlined, 'Data do agendamento',
              dataHoraBr(a.dataHora)),
          _info(Icons.place_outlined, 'Local', a.endereco),
          _info(Icons.bookmark_border, 'Etapa da doacao', a.etapa),
          const SizedBox(height: 4),
          AgendamentoStatusChip(status: a.status),
        ],
      ),
    );
  }

  Widget _colunaAcoes(Agendamento a) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (a.encerrado) _avisoEncerrado(a),
        _cardOrientacao(a),
        const SizedBox(height: 20),
        if (!a.encerrado) _formulario(a) else _historico(a),
      ],
    );
  }

  Widget _avisoEncerrado(Agendamento a) {
    final erro = a.status == StatusAgendamento.naoRealizada;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: erro ? const Color(0xFFFDECEC) : const Color(0xFFE9F6F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: erro ? const Color(0xFFF5C9C9) : const Color(0xFFC7E9DB),
        ),
      ),
      child: Row(
        children: [
          Icon(
            erro ? Icons.error_outline : Icons.check_circle_outline,
            size: 18,
            color: erro ? const Color(0xFFCF3030) : const Color(0xFF0F6E56),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              erro
                  ? 'Este agendamento foi encerrado - a etapa nao pode ser '
                      'concluida.'
                  : 'Este agendamento foi concluido com sucesso.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                    erro ? const Color(0xFFCF3030) : const Color(0xFF0F6E56),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardOrientacao(Agendamento a) {
    return _cartao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rotuloSecao(Icons.assignment_outlined, 'ORIENTACAO DA ETAPA'),
          const SizedBox(height: 10),
          Text(
            a.etapa,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            a.descricao,
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  /// Formulario de atualizacao: escolha do resultado e relatorio da visita.
  Widget _formulario(Agendamento a) {
    return _cartao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rotuloSecao(Icons.edit_note, 'ATUALIZAR STATUS DA ETAPA'),
          const SizedBox(height: 6),
          Text(
            'Selecione o novo status e registre o relatorio desta etapa '
            '(${a.etapa}).',
            style: const TextStyle(fontSize: 13, color: _cinza),
          ),
          const SizedBox(height: 16),
          _opcaoStatus(
            valor: StatusAgendamento.realizada,
            titulo: 'Realizada',
            descricao: 'Acao deu certo e a etapa foi concluida.',
            cor: const Color(0xFF0F6E56),
          ),
          const SizedBox(height: 10),
          _opcaoStatus(
            valor: StatusAgendamento.naoRealizada,
            titulo: 'Nao realizada',
            descricao: 'Etapa nao deu certo e a doacao foi encerrada.',
            cor: const Color(0xFFCF3030),
          ),
          const SizedBox(height: 20),
          const Text(
            'Relatorio de etapa',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _relatorio,
            maxLines: 4,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText:
                  'Descreva o resultado desta etapa e os proximos passos...',
              hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFC0C7D1)),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.blue),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: AppColors.white,
                minimumSize: const Size(0, 46),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _salvando ? null : _salvar,
              icon: _salvando
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : const Icon(Icons.save_outlined, size: 16),
              label: Text(
                _salvando ? 'Salvando...' : 'Salvar alteracoes',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _opcaoStatus({
    required StatusAgendamento valor,
    required String titulo,
    required String descricao,
    required Color cor,
  }) {
    final selecionado = _statusEscolhido == valor;

    return InkWell(
      onTap: () => setState(() => _statusEscolhido = valor),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selecionado ? cor.withValues(alpha: 0.06) : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selecionado ? cor : const Color(0xFFE2E8F0),
            width: selecionado ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selecionado
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
              color: selecionado ? cor : const Color(0xFFC0C7D1),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: selecionado ? cor : _tinta,
                    ),
                  ),
                  Text(
                    descricao,
                    style: const TextStyle(fontSize: 12.5, color: _cinza),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historico(Agendamento a) {
    return _cartao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rotuloSecao(Icons.description_outlined, 'HISTORICO DE RELATORIOS'),
          const SizedBox(height: 14),
          if (a.relatorios.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEEF1F5)),
              ),
              child: const Text(
                'Nenhum relatorio registrado ainda.',
                style: TextStyle(fontSize: 13, color: _cinza),
              ),
            )
          else
            ...a.relatorios.map(
              (r) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEEF1F5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            r.etapa,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: _tinta,
                            ),
                          ),
                        ),
                        Text(
                          dataHoraBr(r.data),
                          style: const TextStyle(fontSize: 12, color: _cinza),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      r.texto,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Color(0xFF4B5563),
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

  Widget _rotuloSecao(IconData icone, String texto) {
    return Row(
      children: [
        Icon(icone, size: 16, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 8),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _info(IconData icone, String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, size: 18, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rotulo,
                    style: const TextStyle(fontSize: 12, color: _cinza)),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _tinta,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartao({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: child,
    );
  }
}
