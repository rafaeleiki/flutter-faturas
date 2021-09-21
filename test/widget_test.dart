// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faturas/main.dart';

void main() {
  testWidgets('Has 3 buttons', (tester) async {
    await tester.pumpWidget(Faturas());

    expect(find.byKey(const Key('copy_button')), findsOneWidget);
    expect(find.byKey(const Key('send_boleto_button')), findsOneWidget);
    expect(find.byKey(const Key('pay_by_credit_card_button')), findsOneWidget);
  });
  
  testWidgets('Shows how much was the last invoice', (tester) async {
      await tester.pumpWidget(Faturas());

      // Verify that our counter starts at 0.
      expect(find.text('R\$3.025,49'), findsOneWidget);
  });
}
