/// Tipo de conta na visao administrativa.
enum TipoUsuario { doadora, enfermeiro, administrador }

/// Usuario do sistema exibido na gestao de usuarios (visao do administrador).
class UsuarioSistema {
  final String nome;
  final String email;
  final String cidade;
  final TipoUsuario tipo;
  final int doacoes;
  final bool ativo;

  const UsuarioSistema({
    required this.nome,
    required this.email,
    required this.cidade,
    required this.tipo,
    required this.doacoes,
    required this.ativo,
  });

  String get tipoLabel => switch (tipo) {
        TipoUsuario.doadora => 'Doadora',
        TipoUsuario.enfermeiro => 'Enfermeiro(a)',
        TipoUsuario.administrador => 'Administrador',
      };
}
