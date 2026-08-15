import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme/app_colors.dart';
import '../data/mock_usuaria.dart';

/// Item do menu lateral: navega para uma aba (indice) ou dispara uma acao,
/// como a EVA - que no produto real e um widget global, nao uma pagina.
class ItemMenu {
  final String rotulo;
  final IconData icone;
  final int? aba;
  final VoidCallback? acao;

  const ItemMenu({
    required this.rotulo,
    required this.icone,
    this.aba,
    this.acao,
  });
}

/// Menu lateral direito do app, espelhando
/// web-nutriz/src/components/layout/AppDrawer.tsx: cabecalho azul com avatar
/// de iniciais, itens de navegacao com marcador lateral no item ativo e
/// "Sair da conta" no rodape.
class AppDrawer extends StatelessWidget {
  final int abaAtual;
  final ValueChanged<int> onSelecionarAba;
  final VoidCallback onAbrirEva;

  const AppDrawer({
    super.key,
    required this.abaAtual,
    required this.onSelecionarAba,
    required this.onAbrirEva,
  });

  String get _iniciais {
    final partes = usuariaMock.nome.trim().split(' ');
    return partes
        .take(2)
        .map((p) => p.isEmpty ? '' : p[0])
        .join()
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final itens = <ItemMenu>[
      const ItemMenu(rotulo: 'Inicio', icone: Icons.home_outlined, aba: 0),
      const ItemMenu(
          rotulo: 'Pontos de Coleta', icone: Icons.place_outlined, aba: 2),
      const ItemMenu(
          rotulo: 'Minhas doacoes', icone: Icons.water_drop_outlined, aba: 1),
      const ItemMenu(
          rotulo: 'Conteudo educativo',
          icone: Icons.menu_book_outlined,
          aba: 3),
      const ItemMenu(rotulo: 'Perfil', icone: Icons.person_outline, aba: 4),
      ItemMenu(
        rotulo: 'EVA - Assistente Virtual',
        icone: Icons.chat_bubble_outline,
        acao: onAbrirEva,
      ),
    ];

    return Drawer(
      width: 300,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          _cabecalho(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: itens.map((item) => _item(context, item)).toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.line),
          _sair(context),
        ],
      ),
    );
  }

  Widget _cabecalho(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.drawerBlue,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _iniciais,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    usuariaMock.nome,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -8,
              right: -8,
              child: IconButton(
                icon: Icon(Icons.close,
                    color: AppColors.white.withValues(alpha: 0.8), size: 20),
                tooltip: 'Fechar menu',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, ItemMenu item) {
    final ativo = item.aba != null && item.aba == abaAtual;

    return Material(
      color: ativo ? const Color(0xFFEFF6FF) : AppColors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (item.acao != null) {
            item.acao!();
          } else if (item.aba != null) {
            onSelecionarAba(item.aba!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: ativo ? AppColors.drawerBlue : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(
                item.icone,
                size: 20,
                color: ativo ? AppColors.drawerBlue : const Color(0xFF334155),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item.rotulo,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        ativo ? AppColors.drawerBlue : const Color(0xFF334155),
                    fontWeight: ativo ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sair(BuildContext context) {
    return SafeArea(
      top: false,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.landing,
            (route) => false,
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Row(
            children: [
              Icon(Icons.logout, size: 16, color: Color(0xFFEF4444)),
              SizedBox(width: 12),
              Text(
                'Sair da conta',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
