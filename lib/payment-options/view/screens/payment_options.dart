import 'package:faturas/payment-options/model/payment_options_model.dart';
import 'package:faturas/payment-options/view/widgets/payment_options_widget.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

NumberFormat nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PaymentOption> paymentOptions = [
      PaymentOption(1, 3180.0, 3180.0),
      PaymentOption(2, 1630.0, 3260.0),
      PaymentOption(3, 1086.67, 3260.0),
      PaymentOption(4, 815.0, 3260.0),
      PaymentOption(5, 662.0, 3310.0),
      PaymentOption(6, 551.67, 3310.0),
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PaymentOptionsModel(3180, paymentOptions)),
        ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
          create: (context) =>
              PaymentOptionsViewModel(context.read<PaymentOptionsModel>()),
          update: (context, paymentOptionsModel, notifier) =>
              PaymentOptionsViewModel(paymentOptionsModel),
        )
      ],
      child: const PaymentOptionsWidget(),
    );
  }
}
