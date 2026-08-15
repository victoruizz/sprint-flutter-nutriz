import 'bebe.dart';
import 'endereco.dart';

/// Nutriz doadora (espelha a entidade user, tipo 'common', do dominio real).
class Nutriz {
  final String nome;
  final String email;
  final String telefone;
  final DateTime nascimento;
  final double leiteDoadoMl;
  final Bebe? bebe;
  final Endereco? endereco;

  const Nutriz({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.nascimento,
    required this.leiteDoadoMl,
    this.bebe,
    this.endereco,
  });

  String get primeiroNome => nome.split(' ').first;

  int get idade {
    final agora = DateTime.now();
    var anos = agora.year - nascimento.year;
    final fezAniversario = (agora.month > nascimento.month) ||
        (agora.month == nascimento.month && agora.day >= nascimento.day);
    if (!fezAniversario) anos--;
    return anos;
  }
}
