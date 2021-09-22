import 'package:faturas/payment-options/model/payment_option.dart';

class PaymentOptionsModel {
  final double _invoiceValue;
  final List<PaymentOption> _paymentOptions;

  PaymentOptionsModel(this._invoiceValue, this._paymentOptions);

  double get invoiceValue => _invoiceValue;

  List<PaymentOption> get paymentOptions => _paymentOptions;
}
