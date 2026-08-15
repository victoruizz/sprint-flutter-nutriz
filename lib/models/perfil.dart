/// Papeis de usuario do produto (espelha o enum de tipo do backend real).
enum PerfilUsuario { nutriz, adm, nurse }

extension PerfilUsuarioX on PerfilUsuario {
  String get titulo => switch (this) {
        PerfilUsuario.nutriz => 'Doadora',
        PerfilUsuario.adm => 'Administrador',
        PerfilUsuario.nurse => 'Enfermeiro(a)',
      };
}
