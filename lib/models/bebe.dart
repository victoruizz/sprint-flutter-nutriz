/// Bebe da nutriz (espelha user_baby do dominio real).
class Bebe {
  final String nome;
  final DateTime nascimento;

  const Bebe({required this.nome, required this.nascimento});

  int get idadeEmDias => DateTime.now().difference(nascimento).inDays;

  int get idadeEmMeses => (idadeEmDias / 30).floor();

  /// Descricao da fase, alinhada a logica da EVA (colostro/transicao/maduro).
  String get faseDescricao {
    final dias = idadeEmDias;
    if (dias < 7) return 'Recem-nascido - fase de colostro';
    if (dias < 15) return 'Leite de transicao';
    if (dias < 180) return '$idadeEmMeses meses - leite maduro, fase ideal de doacao';
    return '$idadeEmMeses meses - amamentacao prolongada';
  }
}
