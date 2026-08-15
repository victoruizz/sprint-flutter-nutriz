// Teste de fumaca: garante que o app sobe e exibe a tela de splash.

import 'package:flutter_test/flutter_test.dart';

import 'package:nutriz_app/app.dart';

void main() {
  testWidgets('App abre na tela de splash com o botao Comecar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NutrizApp());
    await tester.pumpAndSettle();

    expect(find.text('Comecar'), findsOneWidget);
  });
}
