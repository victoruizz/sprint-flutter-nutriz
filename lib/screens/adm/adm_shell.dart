import 'package:flutter/material.dart';

import '../../models/perfil.dart';
import '../profile/profile_screen.dart';
import 'dashboard_screen.dart';
import 'donations_admin_screen.dart';
import 'users_screen.dart';

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
      body: IndexedStack(index: _index, children: _telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Painel',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Doacoes',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Usuarios',
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
