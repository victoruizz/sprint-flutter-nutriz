import 'package:flutter/material.dart';

import '../../models/perfil.dart';
import '../profile/profile_screen.dart';
import 'appointments_screen.dart';

/// Casca da area do enfermeiro(a): agendamentos e perfil.
class NurseShell extends StatefulWidget {
  const NurseShell({super.key});

  @override
  State<NurseShell> createState() => _NurseShellState();
}

class _NurseShellState extends State<NurseShell> {
  int _index = 0;

  static const _telas = [
    AppointmentsScreen(),
    ProfileScreen(perfil: PerfilUsuario.nurse),
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
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Agendamentos',
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
