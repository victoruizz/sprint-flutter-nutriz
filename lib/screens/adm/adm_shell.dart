import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/perfil.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../profile/profile_screen.dart';
import 'dashboard_screen.dart';
import 'donations_admin_screen.dart';
import 'users_screen.dart';

/// Area administrativa. Usa o mesmo chrome do resto do app - header navy com
/// a wordmark e menu lateral - como o Layout do web-nutriz, que e unico para
/// todos os perfis; o que muda sao os itens do menu.
class AdmShell extends StatefulWidget {
  const AdmShell({super.key});

  @override
  State<AdmShell> createState() => _AdmShellState();
}

class _AdmShellState extends State<AdmShell> {
  int _index = 0;

  static const _telas = [
    DashboardScreen(),
    DonationsAdminScreen(),
    UsersScreen(),
    ProfileScreen(perfil: PerfilUsuario.adm),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      appBar: const AppHeader(),
      endDrawer: AppDrawer(
        perfil: PerfilUsuario.adm,
        abaAtual: _index,
        onSelecionarAba: (i) => setState(() => _index = i),
      ),
      body: IndexedStack(index: _index, children: _telas),
    );
  }
}
