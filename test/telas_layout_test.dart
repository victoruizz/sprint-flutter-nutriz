// Garante que as telas internas montam sem estouro de layout no tamanho de
// um celular comum e tambem em tela larga.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nutriz_app/screens/adm/adm_shell.dart';
import 'package:nutriz_app/screens/donations/new_donation_screen.dart';
import 'package:nutriz_app/screens/home/home_shell.dart';
import 'package:nutriz_app/screens/nurse/nurse_shell.dart';
import 'package:nutriz_app/screens/register/register_screen.dart';

Future<void> _montar(WidgetTester tester, Widget tela, Size tamanho) async {
  tester.view.physicalSize = tamanho;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(MaterialApp(home: tela));
  await tester.pump();
}

void main() {
  const celular = Size(390, 844);
  const desktop = Size(1440, 900);

  final telas = <String, Widget Function()>{
    'home da doadora': () => const HomeShell(),
    'minhas doacoes': () => const HomeShell(abaInicial: 1),
    'pontos de coleta': () => const HomeShell(abaInicial: 2),
    'conteudo educativo': () => const HomeShell(abaInicial: 3),
    'perfil': () => const HomeShell(abaInicial: 4),
    'nova doacao': () => const NewDonationScreen(),
    'cadastro': () => const RegisterScreen(),
    'painel adm': () => const AdmShell(),
    'agendamentos': () => const NurseShell(),
  };

  telas.forEach((nome, constroi) {
    testWidgets('$nome monta sem estouro no celular', (tester) async {
      await _montar(tester, constroi(), celular);
      expect(tester.takeException(), isNull);
    });

    testWidgets('$nome monta sem estouro no desktop', (tester) async {
      await _montar(tester, constroi(), desktop);
      expect(tester.takeException(), isNull);
    });
  });
}
