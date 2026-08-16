import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../content/content_screen.dart';
import '../donations/donations_screen.dart';
import '../eva/eva_chat_screen.dart';
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

  void _abrirEva() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EvaChatScreen()),
    );
  }

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
      body: IndexedStack(index: _index, children: telas),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirEva,
        backgroundColor: AppColors.teal,
        foregroundColor: AppColors.white,
        tooltip: 'Falar com a EVA',
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
