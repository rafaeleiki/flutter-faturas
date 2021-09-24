import 'package:faturas/main.dart';
import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:faturas/payment-options/repository/rest/payment_options_rest_service.dart';
import 'package:flutter/cupertino.dart';

class PaymentOptionsModel extends ChangeNotifier {
  double _invoiceValue;
  List<PaymentOption>? _paymentOptions;
  PaymentOption? _selectedOption;

  PaymentOptionsModel(this._invoiceValue);

  PaymentOptionsModel.withOptions(
      this._invoiceValue, List<PaymentOption> paymentOptions) {
    _selectedOption = paymentOptions[0];
  }

  double get invoiceValue => _invoiceValue;

  PaymentOption? get selectedOption => _selectedOption;

  Future<List<PaymentOption>> get paymentOptions async {
    if (_paymentOptions == null) {
      paymentOptions = await getIt<PaymentOptionsRestService>().fetchPaymentOptions();
      _invoiceValue = _paymentOptions![0].total;
    }

    return Future.value(_paymentOptions);
  }

  set paymentOptions(options) {
    _paymentOptions = options;
    selectedOption = options[0];
  }

  set selectedOption(PaymentOption? option) {
    _selectedOption = option;
    notifyListeners();
  }
}
