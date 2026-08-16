/// Situacao de uma etapa da doacao. `erro` encerra a doacao inteira, como no
/// fluxo do web-nutriz (EnumDonationStepStatus.Failed).
enum StatusEtapa { concluida, emAndamento, pendente, erro }

class EtapaDoacao {
  final String titulo;
  final String descricao;
  final StatusEtapa status;
  final DateTime? data;

  /// Enfermeira designada para a etapa (o "job" atribuido no site).
  final String? enfermeira;

  /// Observacao registrada pela administracao ao finalizar ou marcar erro.
  final String? observacao;

  const EtapaDoacao({
    required this.titulo,
    required this.descricao,
    required this.status,
    this.data,
    this.enfermeira,
    this.observacao,
  });

  EtapaDoacao copyWith({
    StatusEtapa? status,
    DateTime? data,
    String? enfermeira,
    String? observacao,
  }) {
    return EtapaDoacao(
      titulo: titulo,
      descricao: descricao,
      status: status ?? this.status,
      data: data ?? this.data,
      enfermeira: enfermeira ?? this.enfermeira,
      observacao: observacao ?? this.observacao,
    );
  }
}
