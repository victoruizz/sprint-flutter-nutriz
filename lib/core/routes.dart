class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  /// Areas da doadora, cada uma com a propria rota como no site.
  static const String doacoes = '/minhas-doacoes';
  static const String pontos = '/pontos-de-coleta';
  static const String conteudo = '/conteudo-educativo';
  static const String perfil = '/perfil';

  /// Areas internas por perfil, como o roteador privado do web-nutriz separa
  /// nutriz, administracao e enfermagem.
  static const String adm = '/adm';
  static const String nurse = '/enfermagem';
}
