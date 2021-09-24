import 'package:faturas/shared/model/payment_option/payment_option.dart';
import 'package:faturas/shared/model/payment_option/payment_options_model.dart';
import 'package:faturas/payment_options/repository/rest/payment_options_rest_service.dart';
import 'package:faturas/payment_options/view/screens/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'payment_options_test.mocks.dart';

final getIt = GetIt.instance;

@GenerateMocks([PaymentOptionsRestService])
void main() {
  group('PaymentOptionsScreen', () {
    final mockService = MockPaymentOptionsRestService();
    final mockedList = [
      PaymentOption(1, 3180.0, 3180.0),
      PaymentOption(2, 1630.0, 3260.0),
      PaymentOption(3, 1086.67, 3260.0),
      PaymentOption(4, 815.0, 3260.0),
      PaymentOption(5, 662.0, 3310.0),
      PaymentOption(6, 551.67, 3310.0),
    ];

    when(mockService.fetchPaymentOptions())
        .thenAnswer((_) => Future.value(mockedList));

    getIt.registerSingleton<PaymentOptionsRestService>(mockService);

    Future render(WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (_) => PaymentOptionsModel(3180.0),
        child: const MaterialApp(home: PaymentOptionsScreen()),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets('Renders', (tester) async {
      await render(tester);

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
      await render(tester);

      await tester.dragUntilVisible(
        find.byKey(const Key('payment_option_4')),
        find.byType(ListView),
        const Offset(0, 50),
      );
      Finder optionFinder = find.byKey(const Key('payment_option_4'));
      Finder costFinder = find.byKey(const Key('operation_cost'));

      expect((tester.firstWidget(costFinder) as Text).data, 'R\$ 0,00');

      await tester.tap(optionFinder);
      await tester.pumpAndSettle();

      expect((tester.firstWidget(costFinder) as Text).data, 'R\$ 80,00');
    });
  });
}
