// Verifica o alinhamento do header da landing e dos chips da EVA, comparando
// as posicoes reais dos elementos renderizados.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nutriz_app/screens/landing/landing_screen.dart';
import 'package:nutriz_app/widgets/nutriz_logo.dart';

Future<void> _montar(WidgetTester tester, double largura) async {
  tester.view.physicalSize = Size(largura, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const MaterialApp(home: LandingScreen()));
  await tester.pump();
}

void main() {
  testWidgets('os chips da EVA tem a largura do texto e dividem a linha',
      (tester) async {
    await _montar(tester, 1440);

    const rotulos = [
      'Posso doar leite?',
      'Como fazer a ordenha?',
      'Como armazenar o leite?',
      'Como agendar a coleta?',
    ];

    // O bug era o chip esticar ate a largura toda, empurrando cada um para
    // uma linha propria. Cada chip deve ocupar so o espaco do seu texto.
    // (a fonte dos testes e bem mais larga que a real, por isso a folga)
    for (final rotulo in rotulos) {
      final chip = find.ancestor(
        of: find.text(rotulo),
        matching: find.byType(Container),
      );
      final largura = tester.getRect(chip.first).width;

      expect(largura, lessThan(500),
          reason: 'chip "$rotulo" esticou para $largura px');
    }

    // Com chips do tamanho certo, pelo menos dois cabem na mesma linha.
    final topos = rotulos.map((t) => tester.getRect(find.text(t)).top).toSet();
    expect(topos.length, lessThan(rotulos.length),
        reason: 'os chips ficaram um por linha: $topos');
  });

  testWidgets('no desktop a logo nao encosta na nav nem nos botoes',
      (tester) async {
    await _montar(tester, 1440);

    // A logo do header e a ultima NutrizLogo da arvore (a primeira e a do
    // rodape, que fica dentro da area rolavel).
    final logos = find.byType(NutrizLogo);
    final logo = tester.getRect(logos.at(logos.evaluate().length - 1));
    final cadastrar = tester.getRect(find.text('Cadastrar-se'));

    expect(logo.top, closeTo(cadastrar.top, 40),
        reason: 'logo e botoes deveriam estar na mesma faixa do header');
    expect(logo.right, lessThan(cadastrar.left),
        reason: 'a logo esta sobrepondo os botoes do header');
    expect(logo.width, greaterThan(0),
        reason: 'a logo precisa reservar largura no layout');
  });

  testWidgets('no celular a logo nao encosta no botao de menu', (tester) async {
    await _montar(tester, 390);

    final logos = find.byType(NutrizLogo);
    final logo = tester.getRect(logos.at(logos.evaluate().length - 1));
    final menu = tester.getRect(find.byIcon(Icons.menu));

    expect(logo.right, lessThan(menu.left),
        reason: 'a logo esta sobrepondo o botao de menu');
  });
}
