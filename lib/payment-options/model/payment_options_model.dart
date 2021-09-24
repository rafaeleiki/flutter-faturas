import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:flutter/cupertino.dart';

class PaymentOptionsModel extends ChangeNotifier {
  final double _invoiceValue;
  final List<PaymentOption> _paymentOptions;
  late PaymentOption _selectedOption;

  PaymentOptionsModel(this._invoiceValue, this._paymentOptions) {
    _selectedOption = _paymentOptions[0];
  }

  double get invoiceValue => _invoiceValue;

  List<PaymentOption> get paymentOptions => _paymentOptions;

  PaymentOption get selectedOption => _selectedOption;

  set selectedOption(PaymentOption option) {
    _selectedOption = option;
    notifyListeners();
  }
}
