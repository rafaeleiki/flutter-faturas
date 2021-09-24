import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:faturas/shared/model/payment_option/payment_option.dart';
import 'package:faturas/shared/model/payment_option/payment_options_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentOptionsViewModel', () {
    group('operationCost', () {
      test('works when has selectedOption', () {
        final paymentOption = PaymentOption(1, 100, 500);
        final subject = PaymentOptionsViewModel(
            PaymentOptionsModel.withOptions(100, [paymentOption])
        );

        subject.selectedOption = paymentOption;
        expect(subject.operationCost, 400);
      });

      test('works when selectedOption is null', () {
        final subject = PaymentOptionsViewModel(PaymentOptionsModel(100));
        expect(subject.operationCost, 0);
      });
    });
  });
}
