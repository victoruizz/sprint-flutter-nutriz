import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/perfil.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../profile/profile_screen.dart';
import 'appointments_screen.dart';

/// Area da enfermagem. Mesmo chrome das demais areas; o menu lateral traz
/// apenas Meus Agendamentos e Perfil, como o getUserMenu do site faz para o
/// perfil de enfermagem.
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
      backgroundColor: AppColors.appBg,
      appBar: const AppHeader(),
      endDrawer: AppDrawer(
        perfil: PerfilUsuario.nurse,
        abaAtual: _index,
        onSelecionarAba: (i) => setState(() => _index = i),
      ),
      body: IndexedStack(index: _index, children: _telas),
    );
  }
}
