class Endereco {
  final String cep;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String uf;

  const Endereco({
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.uf,
  });

  String get linha => '$rua, $numero';

  String get resumo => '$bairro, $cidade/$uf';

  /// Endereco completo numa linha so, como o site exibe no detalhe da etapa.
  String get linhaCompleta => '$linha - $bairro, $cidade - $uf, $cep';
}
