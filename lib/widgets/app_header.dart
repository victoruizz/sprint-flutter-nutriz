import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'nutriz_logo.dart';

/// Barra superior do app autenticado, espelhando
/// web-nutriz/src/components/layout/Header.tsx: fundo navy, wordmark
/// centralizada e botao de menu (hamburguer) a direita, que abre o AppDrawer.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navy,
      surfaceTintColor: AppColors.navy,
      elevation: 0,
      toolbarHeight: 72,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const NutrizLogo(altura: 34),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white, size: 26),
            tooltip: 'Abrir menu',
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
