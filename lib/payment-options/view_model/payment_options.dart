import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:faturas/payment-options/model/payment_options_model.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel(this._paymentOptionsModel);

  get invoiceValue => _paymentOptionsModel.invoiceValue;

  get paymentOptions => _paymentOptionsModel.paymentOptions;

  double operationCost(PaymentOption paymentOption) =>
      paymentOption.total - invoiceValue;
}
