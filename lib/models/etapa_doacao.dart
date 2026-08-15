/// Situacao de cada etapa da doacao.
enum StatusEtapa { concluida, emAndamento, pendente }

/// Etapa do fluxo de doacao Lactare (espelha donation_step).
class EtapaDoacao {
  final String titulo;
  final String descricao;
  final StatusEtapa status;
  final DateTime? data;

  const EtapaDoacao({
    required this.titulo,
    required this.descricao,
    required this.status,
    this.data,
  });
}
