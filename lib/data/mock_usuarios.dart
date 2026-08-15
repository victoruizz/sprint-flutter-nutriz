import '../models/usuario_sistema.dart';

/// Usuarios do sistema (mock) para a gestao de usuarios do administrador.
const List<UsuarioSistema> usuariosMock = [
  UsuarioSistema(
    nome: 'Mariana Alves',
    email: 'mariana.alves@email.com',
    cidade: 'Sao Paulo',
    tipo: TipoUsuario.doadora,
    doacoes: 4,
    ativo: true,
  ),
  UsuarioSistema(
    nome: 'Beatriz Ramos',
    email: 'beatriz.ramos@email.com',
    cidade: 'Guarulhos',
    tipo: TipoUsuario.doadora,
    doacoes: 2,
    ativo: true,
  ),
  UsuarioSistema(
    nome: 'Juliana Prado',
    email: 'juliana.prado@email.com',
    cidade: 'Osasco',
    tipo: TipoUsuario.doadora,
    doacoes: 1,
    ativo: true,
  ),
  UsuarioSistema(
    nome: 'Fernanda Lima',
    email: 'fernanda.lima@email.com',
    cidade: 'Sao Paulo',
    tipo: TipoUsuario.doadora,
    doacoes: 6,
    ativo: false,
  ),
  UsuarioSistema(
    nome: 'Renata Souza',
    email: 'renata.souza@lactare.org',
    cidade: 'Itapevi',
    tipo: TipoUsuario.enfermeiro,
    doacoes: 0,
    ativo: true,
  ),
  UsuarioSistema(
    nome: 'Carla Menezes',
    email: 'carla.menezes@lactare.org',
    cidade: 'Sao Paulo',
    tipo: TipoUsuario.administrador,
    doacoes: 0,
    ativo: true,
  ),
];
