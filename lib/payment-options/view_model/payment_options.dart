import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:faturas/payment-options/model/payment_options_model.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel(this._paymentOptionsModel);

  get invoiceValue => _paymentOptionsModel.invoiceValue;

  Future<List<PaymentOption>> get paymentOptions async =>
      await _paymentOptionsModel.paymentOptions;

  double get operationCost {
    if (selectedOption == null) {
      return 0.0;
    }
    return selectedOption!.total - invoiceValue;
  }

  PaymentOption? get selectedOption => _paymentOptionsModel.selectedOption;

  set selectedOption(PaymentOption? option) =>
      _paymentOptionsModel.selectedOption = option;
}
