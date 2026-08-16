import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/eva_fab.dart';
import '../../widgets/eva_widget.dart';
import '../content/content_screen.dart';
import '../donations/donations_screen.dart';
import '../points/points_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

/// Casca do app autenticado. Segue o chrome do web-nutriz: header navy fixo
/// com wordmark centralizada e menu lateral direito (AppDrawer) - a navegacao
/// entre areas acontece pelo menu, nao por barra inferior.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  void _irParaAba(int i) => setState(() => _index = i);

  void _abrirEva() => mostrarEvaWidget(context);

  @override
  Widget build(BuildContext context) {
    final telas = [
      HomeScreen(onIrParaAba: _irParaAba, onAbrirEva: _abrirEva),
      const DonationsScreen(),
      const PointsScreen(),
      const ContentScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.appBg,
      appBar: const AppHeader(),
      endDrawer: AppDrawer(
        abaAtual: _index,
        onSelecionarAba: _irParaAba,
        onAbrirEva: _abrirEva,
      ),
      // Cada tela aplica o proprio respiro lateral: a home precisa que o
      // bloco navy va de ponta a ponta, as demais ficam contidas.
      body: IndexedStack(index: _index, children: telas),
      floatingActionButton: EvaFab(onPressed: _abrirEva),
    );
  }
}
