enum StatusAgendamento { aguardando, realizada, naoRealizada }

/// Relatorio registrado pela enfermagem ao concluir uma etapa.
class RelatorioAgendamento {
  final String etapa;
  final DateTime data;
  final String texto;
  final StatusAgendamento resultado;

  const RelatorioAgendamento({
    required this.etapa,
    required this.data,
    required this.texto,
    required this.resultado,
  });
}

class Agendamento {
  final String id;
  final String doadora;
  final String endereco;
  final String etapa;
  final DateTime dataHora;
  final StatusAgendamento status;

  /// Orientacao da etapa, exibida no detalhe para a enfermagem.
  final String descricao;

  /// Historico de relatorios ja registrados neste agendamento.
  final List<RelatorioAgendamento> relatorios;

  const Agendamento({
    required this.id,
    required this.doadora,
    required this.endereco,
    required this.etapa,
    required this.dataHora,
    required this.status,
    this.descricao = '',
    this.relatorios = const [],
  });

  /// Agendamentos concluidos ou com erro nao podem mais ser editados.
  bool get encerrado => status != StatusAgendamento.aguardando;

  String get statusLabel => switch (status) {
        StatusAgendamento.aguardando => 'Aguardando liberacao',
        StatusAgendamento.realizada => 'Realizada',
        StatusAgendamento.naoRealizada => 'Nao realizada',
      };

  Agendamento copyWith({
    StatusAgendamento? status,
    List<RelatorioAgendamento>? relatorios,
  }) {
    return Agendamento(
      id: id,
      doadora: doadora,
      endereco: endereco,
      etapa: etapa,
      dataHora: dataHora,
      status: status ?? this.status,
      descricao: descricao,
      relatorios: relatorios ?? this.relatorios,
    );
  }
}
