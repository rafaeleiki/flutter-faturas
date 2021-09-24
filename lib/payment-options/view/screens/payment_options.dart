import 'package:faturas/payment-options/model/payment_options_model.dart';
import 'package:faturas/payment-options/view/widgets/payment_options_widget.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

NumberFormat nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
      create: (context) =>
          PaymentOptionsViewModel(context.read<PaymentOptionsModel>()),
      update: (context, paymentOptionsModel, notifier) =>
          PaymentOptionsViewModel(paymentOptionsModel),
      child: const PaymentOptionsWidget(),
    );
  }
}
