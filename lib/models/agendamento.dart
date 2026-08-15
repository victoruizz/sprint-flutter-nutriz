/// Situacao de um agendamento (visita/acao) do enfermeiro.
enum StatusAgendamento { aguardando, realizada, naoRealizada }

/// Agendamento atendido pelo enfermeiro (espelha job/agendamento do produto).
class Agendamento {
  final String doadora;
  final String endereco;
  final String etapa;
  final DateTime dataHora;
  final StatusAgendamento status;

  const Agendamento({
    required this.doadora,
    required this.endereco,
    required this.etapa,
    required this.dataHora,
    required this.status,
  });

  String get statusLabel => switch (status) {
        StatusAgendamento.aguardando => 'Aguardando liberacao',
        StatusAgendamento.realizada => 'Realizada',
        StatusAgendamento.naoRealizada => 'Nao realizada',
      };
}
