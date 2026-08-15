import 'etapa_doacao.dart';

class Doacao {
  final String id;
  final String titulo;
  final DateTime dataInicio;
  final List<EtapaDoacao> etapas;

  const Doacao({
    required this.id,
    required this.titulo,
    required this.dataInicio,
    required this.etapas,
  });

  int get etapasConcluidas =>
      etapas.where((e) => e.status == StatusEtapa.concluida).length;

  double get progresso => etapas.isEmpty ? 0 : etapasConcluidas / etapas.length;

  bool get concluida => etapasConcluidas == etapas.length;

  String get statusAtual {
    final emAndamento =
        etapas.where((e) => e.status == StatusEtapa.emAndamento).toList();
    if (emAndamento.isNotEmpty) return emAndamento.first.titulo;
    if (concluida) return 'Concluida';
    return etapas.first.titulo;
  }
}
