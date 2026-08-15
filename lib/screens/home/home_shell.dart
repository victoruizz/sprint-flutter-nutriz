import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../content/content_screen.dart';
import '../donations/donations_screen.dart';
import '../eva/eva_chat_screen.dart';
import '../points/points_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

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
      body: IndexedStack(index: _index, children: telas),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirEva,
        backgroundColor: AppColors.teal,
        foregroundColor: AppColors.white,
        tooltip: 'Falar com a EVA',
        child: const Icon(Icons.chat_bubble_outline),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _irParaAba,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Doacoes',
          ),
          NavigationDestination(
            icon: Icon(Icons.place_outlined),
            selectedIcon: Icon(Icons.place),
            label: 'Pontos',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Conteudo',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
