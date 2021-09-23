import 'package:faturas/payment-options/view/screens/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentOptionsScreen', () {
    testWidgets('Renders', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PaymentOptionsScreen()));

      await tester.pumpAndSettle();

      expect(
          find.byKey(const Key('payment_options_container')), findsOneWidget);

      for (var i = 1; i <= 6; i++) {
        await tester.dragUntilVisible(
          find.byKey(Key('payment_option_$i')),
          find.byType(ListView),
          const Offset(0, 50),
        );
        expect(find.byKey(Key('payment_option_$i')), findsOneWidget);
      }
    });

    testWidgets('When a payment option is selected the operation updates',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PaymentOptionsScreen()));

      Finder optionFinder = find.byKey(const Key('payment_option_4'));
      Finder costFinder = find.byKey(const Key('operation_cost'));

      expect((tester.firstWidget(costFinder) as Text).data, 'R\$ 0,00');

      await tester.tap(optionFinder);
      await tester.pumpAndSettle();

      expect((tester.firstWidget(costFinder) as Text).data, 'R\$ 80,00');
    });
  });
}
