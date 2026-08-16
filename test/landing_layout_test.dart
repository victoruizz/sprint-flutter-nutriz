// Garante que o header da landing (wordmark, navegacao e menu) aparece e que
// as secoes nao estouram o layout nas larguras de celular, tablet e desktop.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nutriz_app/screens/landing/landing_screen.dart';

Future<void> _montarLanding(WidgetTester tester, Size tamanho) async {
  tester.view.physicalSize = tamanho;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const MaterialApp(home: LandingScreen()));
  await tester.pump();
}

void main() {
  final larguras = <String, Size>{
    'celular': const Size(390, 844),
    'tablet': const Size(834, 1112),
    'desktop': const Size(1440, 900),
  };

  larguras.forEach((nome, tamanho) {
    testWidgets('landing monta sem erro de layout em $nome', (tester) async {
      await _montarLanding(tester, tamanho);

      expect(tester.takeException(), isNull);
    });

    testWidgets('wordmark aparece no header em $nome', (tester) async {
      await _montarLanding(tester, tamanho);

      final wordmarks = find.byWidgetPredicate(
        (w) =>
            w is Image &&
            w.image is AssetImage &&
            (w.image as AssetImage).assetName.contains('wordmark'),
      );

      expect(wordmarks, findsWidgets);
    });
  });

  testWidgets('no desktop o header mostra os links das secoes',
      (tester) async {
    await _montarLanding(tester, const Size(1440, 900));

    expect(find.text('Como funciona'), findsWidgets);
    expect(find.text('Depoimentos'), findsWidgets);
    expect(find.text('Cadastrar-se'), findsWidgets);
  });

  testWidgets('no celular o header mostra o botao de menu', (tester) async {
    await _montarLanding(tester, const Size(390, 844));

    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
