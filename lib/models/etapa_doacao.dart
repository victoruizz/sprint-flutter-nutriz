enum StatusEtapa { concluida, emAndamento, pendente }

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
