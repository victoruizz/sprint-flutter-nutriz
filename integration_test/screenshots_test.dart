import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nutriz_app/app.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('captura das telas do app', (tester) async {
    await tester.pumpWidget(const NutrizApp());
    await tester.pumpAndSettle();

    Future<void> shot(String name) async {
      await tester.pumpAndSettle();
      await binding.takeScreenshot(name);
    }

    Future<void> back() async {
      await tester.pageBack();
      await tester.pumpAndSettle();
    }

    Future<void> tapNav(String label) async {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> login(String email, {String? role}) async {
      if (role != null) {
        await tester.tap(find.text(role));
        await tester.pumpAndSettle();
      }
      await tester.enterText(find.byType(TextFormField).at(0), email);
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();
    }

    Future<void> logout() async {
      final sair = find.text('Sair');
      await tester.ensureVisible(sair);
      await tester.pumpAndSettle();
      await tester.tap(sair);
      await tester.pumpAndSettle();
    }

    await shot('01_splash');
    await tester.tap(find.text('Comecar'));
    await tester.pumpAndSettle();

    await shot('02_landing');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    await shot('03_login');
    await login('mariana.alves@email.com');

    await shot('04_home_doadora');
    await tester.tap(find.text('DOA-2026-014'));
    await tester.pumpAndSettle();
    await shot('05_doacao_timeline');
    await back();

    await tapNav('Pontos');
    await shot('06_pontos');
    await tester.tap(find.text('Lactare - Banco de Leite Humano'));
    await tester.pumpAndSettle();
    await shot('07_ponto_detalhe');
    await back();

    await tapNav('Conteudo');
    await shot('08_conteudo');
    await tester.tap(find.text('Como armazenar o leite ordenhado'));
    await tester.pumpAndSettle();
    await shot('09_artigo');
    await back();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await shot('10_eva');
    await back();

    await tapNav('Perfil');
    await shot('11_perfil_doadora');
    await logout();

    await login('carla.menezes@lactare.org', role: 'Admin');
    await shot('12_admin_painel');
    await tapNav('Usuarios');
    await shot('13_admin_usuarios');
    await tapNav('Perfil');
    await logout();

    await login('renata.souza@lactare.org', role: 'Enferm.');
    await shot('14_enfermeiro_agendamentos');
  });
}
