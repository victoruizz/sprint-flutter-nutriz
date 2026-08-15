import '../models/bebe.dart';
import '../models/endereco.dart';
import '../models/nutriz.dart';

final Nutriz usuariaMock = Nutriz(
  nome: 'Mariana Alves',
  email: 'mariana.alves@email.com',
  telefone: '(11) 98765-4321',
  nascimento: DateTime(1994, 6, 12),
  leiteDoadoMl: 1850,
  bebe: Bebe(
    nome: 'Joao',
    nascimento: DateTime.now().subtract(const Duration(days: 120)),
  ),
  endereco: const Endereco(
    cep: '04101-000',
    rua: 'Rua Domingos de Morais',
    numero: '1200',
    bairro: 'Vila Mariana',
    cidade: 'Sao Paulo',
    uf: 'SP',
  ),
);
