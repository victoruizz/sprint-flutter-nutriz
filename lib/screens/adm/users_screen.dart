import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_usuarios.dart';
import '../../models/usuario_sistema.dart';
import '../../widgets/content_container.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/page_title.dart';
import 'user_detail_screen.dart';

/// Gestao de usuarios, seguindo pages/private/users/list do web-nutriz:
/// filtro por perfil, botao de novo usuario, campos de busca e a tabela de
/// usuarios com cabecalho.
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const Color _borda = Color(0xFFEEF1F5);
  static const Color _tinta = Color(0xFF1F2A37);
  static const Color _cinza = Color(0xFF9CA3AF);

  TipoUsuario? _filtro;

  @override
  Widget build(BuildContext context) {
    final usuarios = _filtro == null
        ? usuariosMock
        : usuariosMock.where((u) => u.tipo == _filtro).toList();

    return ContentContainer(
      larguraMaxima: 1400,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const PageTitle(
            titulo: 'Usuarios',
            descricao: 'Gerencie os acessos do Nutriz',
          ),
          _linhaFiltros(),
          const SizedBox(height: 16),
          _buscas(),
          const SizedBox(height: 20),
          _tabela(usuarios),
        ],
      ),
    );
  }

  Widget _linhaFiltros() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final chips = FilterChips<TipoUsuario?>(
          opcoes: const [
            (valor: null, rotulo: 'Todos'),
            (valor: TipoUsuario.doadora, rotulo: 'Doadoras'),
            (valor: TipoUsuario.enfermeiro, rotulo: 'Enfermagem'),
            (valor: TipoUsuario.administrador, rotulo: 'Administracao'),
          ],
          selecionado: _filtro,
          onSelecionar: (v) => setState(() => _filtro = v),
        );

        final botao = ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navy,
            foregroundColor: AppColors.white,
            minimumSize: const Size(0, 43),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Criacao de usuario disponivel na versao completa.'),
            ),
          ),
          icon: const Icon(Icons.add, size: 16),
          label: const Text(
            'Novo usuario',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        );

        if (constraints.maxWidth >= 760) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Flexible(child: chips), botao],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [chips, const SizedBox(height: 12), botao],
        );
      },
    );
  }

  Widget _buscas() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const campos = [
          SearchBarNutriz(dica: 'Buscar por nome...'),
          SearchBarNutriz(dica: 'Buscar por CPF...'),
          SearchBarNutriz(dica: 'Buscar por identificador interno...'),
        ];

        if (constraints.maxWidth >= 760) {
          return Row(
            children: [
              for (var i = 0; i < campos.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(child: campos[i]),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (final c in campos)
              Padding(padding: const EdgeInsets.only(bottom: 10), child: c),
          ],
        );
      },
    );
  }

  Widget _tabela(List<UsuarioSistema> usuarios) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: const Color(0xFFF9FAFB),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: const Row(
              children: [
                Expanded(flex: 3, child: _Cabecalho('Usuario')),
                Expanded(flex: 2, child: _Cabecalho('Perfil')),
                Expanded(flex: 2, child: _Cabecalho('Cidade')),
                SizedBox(width: 80, child: _Cabecalho('Status')),
              ],
            ),
          ),
          if (usuarios.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Text(
                    'Nenhum usuario encontrado',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _tinta,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ajuste a busca ou o filtro selecionado.',
                    style: TextStyle(fontSize: 13, color: _cinza),
                  ),
                ],
              ),
            )
          else
            ...usuarios.map((u) => _linha(context, u)),
        ],
      ),
    );
  }

  Widget _linha(BuildContext context, UsuarioSistema usuario) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => UserDetailScreen(usuario: usuario)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: _borda)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.blueSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      usuario.nome
                          .split(' ')
                          .take(2)
                          .map((p) => p[0])
                          .join()
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A77B0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usuario.nome,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _tinta,
                          ),
                        ),
                        Text(
                          usuario.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 12, color: _cinza),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2, child: _etiquetaPerfil(usuario.tipo)),
            Expanded(
              flex: 2,
              child: Text(
                usuario.cidade,
                style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                usuario.ativo ? 'Ativo' : 'Inativo',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: usuario.ativo ? const Color(0xFF0F766E) : _cinza,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Cores por perfil vindas do constants.ts do site.
  Widget _etiquetaPerfil(TipoUsuario tipo) {
    final (fundo, cor, rotulo) = switch (tipo) {
      TipoUsuario.administrador => (
          const Color(0xFFE8F0FE),
          AppColors.navy,
          'Administracao'
        ),
      TipoUsuario.enfermeiro => (
          const Color(0xFFEDE9FE),
          const Color(0xFF6D28D9),
          'Enfermagem'
        ),
      TipoUsuario.doadora => (
          const Color(0xFFD5F3EA),
          const Color(0xFF0F766E),
          'Doadora'
        ),
    };

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: fundo,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          rotulo,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cor,
          ),
        ),
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  final String texto;

  const _Cabecalho(this.texto);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: Color(0xFF6B7280),
      ),
    );
  }
}
