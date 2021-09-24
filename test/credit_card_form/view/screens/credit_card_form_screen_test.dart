import 'package:faturas/credit_card_form/view/credit_card_form_screen.dart';
import 'package:faturas/shared/model/credit_card/credit_card.dart';
import 'package:faturas/shared/model/credit_card/user_credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('CreditCardFormScreen', () {

    Future render(WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (_) => UserCreditCardModel(CreditCard(cvv: '123')),
        child: const MaterialApp(home: CreditCardFormScreen()),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets('Renders', (tester) async {
      await render(tester);

      expect(find.byType(TextField), findsNWidgets(4));
    });

  });
}
