class PontoColeta {
  final String nome;
  final String endereco;
  final String bairro;
  final String cidade;
  final double distanciaKm;
  final bool aberto;
  final bool coletaDomiciliar;
  final String horario;

  const PontoColeta({
    required this.nome,
    required this.endereco,
    required this.bairro,
    required this.cidade,
    required this.distanciaKm,
    required this.aberto,
    required this.coletaDomiciliar,
    required this.horario,
  });

  String get tipoColeta =>
      coletaDomiciliar ? 'Coleta domiciliar' : 'Coleta no ponto';
}
