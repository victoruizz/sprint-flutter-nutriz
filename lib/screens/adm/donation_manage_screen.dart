import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_usuarios.dart';
import '../../models/doacao.dart';
import '../../models/etapa_doacao.dart';
import '../../models/usuario_sistema.dart';
import '../../widgets/app_page.dart';

/// Gestao de uma doacao pela administracao, seguindo
/// pages/private/donations/adm/info do web-nutriz.
///
/// A administracao controla a doacao etapa a etapa: agenda (data, hora e
/// enfermeira responsavel), **finaliza** - o que libera a etapa seguinte - ou
/// **marca erro**, o que encerra a doacao. Etapas ainda nao liberadas ficam
/// bloqueadas.
class DonationManageScreen extends StatefulWidget {
  final Doacao doacao;
  final String doadora;

  const DonationManageScreen({
    super.key,
    required this.doacao,
    required this.doadora,
  });

  @override
  State<DonationManageScreen> createState() => _DonationManageScreenState();
}

class _DonationManageScreenState extends State<DonationManageScreen> {
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF6B7280);
  static const Color _borda = Color(0xFFE7EAEF);

  late List<EtapaDoacao> _etapas;

  @override
  void initState() {
    super.initState();
    // Copia local: as alteracoes da administracao valem durante a navegacao,
    // sem backend por tras.
    _etapas = List.of(widget.doacao.etapas);
  }

  bool get _encerrada => _etapas.any((e) => e.status == StatusEtapa.erro);

  bool get _concluida =>
      !_encerrada && _etapas.every((e) => e.status == StatusEtapa.concluida);

  /// Indice da primeira etapa ainda nao concluida - e a unica editavel.
  int get _indiceAtual {
    final i = _etapas.indexWhere((e) => e.status != StatusEtapa.concluida);
    return i == -1 ? _etapas.length : i;
  }

  List<String> get _enfermeiras => usuariosMock
      .where((u) => u.tipo == TipoUsuario.enfermeiro)
      .map((u) => u.nome)
      .toList();

  void _agendar(int indice, DateTime data, String? enfermeira) {
    setState(() {
      _etapas[indice] = _etapas[indice].copyWith(
        status: StatusEtapa.emAndamento,
        data: data,
        enfermeira: enfermeira,
      );
    });
    _aviso('Agendamento salvo para "${_etapas[indice].titulo}".');
  }

  void _finalizar(int indice, String observacao) {
    setState(() {
      _etapas[indice] = _etapas[indice].copyWith(
        status: StatusEtapa.concluida,
        observacao: observacao.isEmpty ? null : observacao,
      );
      // Finalizar libera a proxima etapa, como no fluxo do site.
      final proxima = indice + 1;
      if (proxima < _etapas.length &&
          _etapas[proxima].status == StatusEtapa.pendente) {
        _etapas[proxima] =
            _etapas[proxima].copyWith(status: StatusEtapa.emAndamento);
      }
    });
    _aviso('Etapa finalizada. A proxima foi liberada.');
  }

  void _marcarErro(int indice, String motivo) {
    setState(() {
      _etapas[indice] = _etapas[indice].copyWith(
        status: StatusEtapa.erro,
        observacao: motivo.isEmpty ? null : motivo,
      );
    });
    _aviso('Etapa marcada como erro. A doacao foi encerrada.');
  }

  void _aviso(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), backgroundColor: AppColors.navy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      titulo: widget.doacao.id,
      larguraMaxima: 1400,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Text(
            'Informacoes cadastrais e historico da doacao na plataforma',
            style: TextStyle(fontSize: 13.5, color: _cinza),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final emLinha = constraints.maxWidth >= 980;
              final lateral = _colunaLateral();
              final etapas = _colunaEtapas();

              if (emLinha) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 340, child: lateral),
                    const SizedBox(width: 24),
                    Expanded(child: etapas),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [lateral, const SizedBox(height: 24), etapas],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _colunaLateral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _cartao(
          titulo: 'Dados da doacao',
          filhos: [
            _info('Identificador', widget.doacao.id),
            _info('Iniciada em', dataBr(widget.doacao.dataInicio)),
            _info('Etapas concluidas',
                '${_etapas.where((e) => e.status == StatusEtapa.concluida).length} de ${_etapas.length}'),
            _info(
              'Situacao',
              _encerrada
                  ? 'Encerrada com erro'
                  : _concluida
                      ? 'Concluida'
                      : 'Em andamento',
            ),
          ],
        ),
        const SizedBox(height: 16),
        _cartao(
          titulo: 'Doadora',
          filhos: [
            _info('Nome', widget.doadora),
            _info('Perfil', 'Nutriz doadora'),
          ],
        ),
      ],
    );
  }

  Widget _colunaEtapas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Etapas da doacao',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: _tinta,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Gerencie o agendamento e o status de cada etapa. Finalize para '
          'liberar a proxima.',
          style: TextStyle(fontSize: 14, color: _cinza),
        ),
        const SizedBox(height: 16),
        if (_encerrada) _alerta(erro: true),
        if (_concluida) _alerta(erro: false),
        for (var i = 0; i < _etapas.length; i++) ...[
          _CardEtapaAdmin(
            etapa: _etapas[i],
            numero: i + 1,
            bloqueada: i > _indiceAtual || _encerrada,
            editavel: i == _indiceAtual && !_encerrada,
            ultima: i == _etapas.length - 1,
            enfermeiras: _enfermeiras,
            onAgendar: (data, enfermeira) => _agendar(i, data, enfermeira),
            onFinalizar: (obs) => _finalizar(i, obs),
            onMarcarErro: (motivo) => _marcarErro(i, motivo),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _alerta({required bool erro}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: erro ? const Color(0xFFFCEBEB) : const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: erro ? const Color(0xFFF3CACA) : const Color(0xFFBFE3D3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            erro ? Icons.warning_amber_rounded : Icons.check_circle_outline,
            size: 18,
            color: erro ? const Color(0xFFA32D2D) : const Color(0xFF0F6E56),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              erro
                  ? 'Esta doacao foi encerrada - uma das etapas foi marcada '
                      'como erro.'
                  : 'Esta doacao foi concluida com sucesso - todas as etapas '
                      'foram finalizadas.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: erro ? const Color(0xFFA32D2D) : const Color(0xFF0F6E56),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartao({required String titulo, required List<Widget> filhos}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
          const SizedBox(height: 14),
          ...filhos,
        ],
      ),
    );
  }

  Widget _info(String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rotulo,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
          const SizedBox(height: 2),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _tinta,
            ),
          ),
        ],
      ),
    );
  }
}

/// Cartao de uma etapa na visao da administracao: bloqueada, editavel
/// (agendamento + acoes) ou concluida/erro em somente leitura.
class _CardEtapaAdmin extends StatefulWidget {
  final EtapaDoacao etapa;
  final int numero;
  final bool bloqueada;
  final bool editavel;
  final bool ultima;
  final List<String> enfermeiras;
  final void Function(DateTime data, String? enfermeira) onAgendar;
  final ValueChanged<String> onFinalizar;
  final ValueChanged<String> onMarcarErro;

  const _CardEtapaAdmin({
    required this.etapa,
    required this.numero,
    required this.bloqueada,
    required this.editavel,
    required this.ultima,
    required this.enfermeiras,
    required this.onAgendar,
    required this.onFinalizar,
    required this.onMarcarErro,
  });

  @override
  State<_CardEtapaAdmin> createState() => _CardEtapaAdminState();
}

class _CardEtapaAdminState extends State<_CardEtapaAdmin> {
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF6B7280);
  static const Color _borda = Color(0xFFE7EAEF);

  final _observacao = TextEditingController();
  final _quantidade = TextEditingController();
  DateTime? _data;
  String? _enfermeira;

  @override
  void initState() {
    super.initState();
    _data = widget.etapa.data;
    _enfermeira = widget.etapa.enfermeira;
  }

  @override
  void dispose() {
    _observacao.dispose();
    _quantidade.dispose();
    super.dispose();
  }

  Future<void> _escolherData() async {
    final escolhida = await showDatePicker(
      context: context,
      initialDate: _data ?? DateTime(2026, 8, 16),
      firstDate: DateTime(2026),
      lastDate: DateTime(2027, 12, 31),
      helpText: 'Data da etapa',
    );
    if (escolhida != null) setState(() => _data = escolhida);
  }

  @override
  Widget build(BuildContext context) {
    final etapa = widget.etapa;
    final concluida = etapa.status == StatusEtapa.concluida;
    final comErro = etapa.status == StatusEtapa.erro;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: widget.bloqueada ? const Color(0xFFFAFBFC) : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cabecalho(concluida, comErro),
          const SizedBox(height: 16),
          Container(height: 1, color: _borda),
          const SizedBox(height: 16),
          if (widget.bloqueada)
            const Row(
              children: [
                Icon(Icons.lock_outline, size: 16, color: Color(0xFF9CA3AF)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Disponivel apos a conclusao da etapa anterior.',
                    style: TextStyle(fontSize: 13, color: _cinza),
                  ),
                ),
              ],
            )
          else if (concluida || comErro)
            _somenteLeitura(etapa)
          else
            _formularioEdicao(),
        ],
      ),
    );
  }

  Widget _cabecalho(bool concluida, bool comErro) {
    final (cor, fundo, rotulo) = comErro
        ? (const Color(0xFFA32D2D), const Color(0xFFFCEBEB), 'Erro')
        : concluida
            ? (const Color(0xFF0F6E56), const Color(0xFFE1F5EE), 'Concluida')
            : widget.bloqueada
                ? (_cinza, const Color(0xFFF1F3F5), 'Bloqueada')
                : (AppColors.navy, AppColors.blueSoft, 'Em andamento');

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: fundo, shape: BoxShape.circle),
          child: Text(
            '${widget.numero}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: cor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.etapa.titulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: fundo,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            rotulo,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: cor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _somenteLeitura(EtapaDoacao etapa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (etapa.data != null) _linha('Data', dataBr(etapa.data!)),
        if (etapa.enfermeira != null)
          _linha('Responsavel', etapa.enfermeira!),
        if (etapa.observacao != null)
          _linha('Observacao', etapa.observacao!)
        else
          _linha('Descricao', etapa.descricao),
      ],
    );
  }

  Widget _linha(String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(rotulo,
                style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(
                  fontSize: 13.5, height: 1.4, color: _tinta),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formularioEdicao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DADOS DO AGENDAMENTO - EDITAVEL',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _tinta,
                  minimumSize: const Size(0, 44),
                  alignment: Alignment.centerLeft,
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _escolherData,
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: Text(
                  _data == null ? 'Escolher data' : dataBr(_data!),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _enfermeira,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Enfermeira responsavel',
            labelStyle: const TextStyle(fontSize: 13),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: widget.enfermeiras
              .map((n) => DropdownMenuItem(value: n, child: Text(n)))
              .toList(),
          onChanged: (v) => setState(() => _enfermeira = v),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navy,
              foregroundColor: AppColors.white,
              minimumSize: const Size(0, 42),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _data == null
                ? null
                : () => widget.onAgendar(_data!, _enfermeira),
            child: const Text(
              'Salvar agendamento',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(height: 1, color: _borda),
        const SizedBox(height: 16),
        TextField(
          controller: _observacao,
          maxLines: 2,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Observacao da etapa (opcional)',
            hintStyle: const TextStyle(fontSize: 13.5),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        if (widget.ultima) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _quantidade,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: 'Quantidade doada (ml)',
              labelStyle: const TextStyle(fontSize: 13),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6E56),
                foregroundColor: AppColors.white,
                minimumSize: const Size(0, 44),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => widget.onFinalizar(_observacao.text),
              icon: const Icon(Icons.check, size: 16),
              label: const Text(
                'Finalizar etapa',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFA32D2D),
                minimumSize: const Size(0, 44),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                side: const BorderSide(color: Color(0xFFF3CACA)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => widget.onMarcarErro(_observacao.text),
              icon: const Icon(Icons.warning_amber_rounded, size: 16),
              label: const Text(
                'Marcar como erro',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
