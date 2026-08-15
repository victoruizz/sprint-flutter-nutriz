class UsuarioLogado {
  final String nome;
  final String email;
  final String cargo;

  const UsuarioLogado({
    required this.nome,
    required this.email,
    required this.cargo,
  });

  String get primeiroNome => nome.split(' ').first;
}

const UsuarioLogado adminMock = UsuarioLogado(
  nome: 'Carla Menezes',
  email: 'carla.menezes@lactare.org',
  cargo: 'Administradora',
);

const UsuarioLogado nurseMock = UsuarioLogado(
  nome: 'Renata Souza',
  email: 'renata.souza@lactare.org',
  cargo: 'Enfermeira',
);
