import 'package:faturas/payment-options/model/payment_options_model.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:intl/intl.dart';

NumberFormat nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  late PaymentOptionsViewModel _paymentOptionsViewModel;
  late PaymentOption selectedOption;

  @override
  void initState() {
    super.initState();

    PaymentOptionsModel paymentOptionsModel = PaymentOptionsModel(3180, [
      PaymentOption(1, 3180.0, 3180.0),
      PaymentOption(2, 1630.0, 3260.0),
      PaymentOption(3, 1086.67, 3260.0),
      PaymentOption(4, 815.0, 3260.0),
      PaymentOption(5, 662.0, 3310.0),
      PaymentOption(6, 551.67, 3310.0),
    ]);
    _paymentOptionsViewModel = PaymentOptionsViewModel(paymentOptionsModel);

    selectedOption = _paymentOptionsViewModel.paymentOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? boldTextStyle = Theme.of(context).textTheme.bodyText1;
    double operationCost =
        _paymentOptionsViewModel.operationCost(selectedOption);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Pagamento da fatura',
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Escolha o número de parcelas:',
                style: boldTextStyle,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _paymentOptionsViewModel.paymentOptions.length,
                itemBuilder: (context, index) {
                  return PaymentPortionItem(
                    selectedOption: selectedOption,
                    onChanged: (value) =>
                        setState(() => selectedOption = value),
                    paymentOption:
                        _paymentOptionsViewModel.paymentOptions[index],
                  );
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('Fatura de junho'),
                          const Spacer(),
                          Text(nf.format(selectedOption.total)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Taxa da operação'),
                        const Spacer(),
                        Text(nf.format(operationCost)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Voltar'),
                    )),
                const Text('1 de 3'),
                ElevatedButton(
                  onPressed: () => {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Continuar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPortionItem extends StatelessWidget {
  const PaymentPortionItem(
      {required this.selectedOption,
      required this.paymentOption,
      this.onChanged,
      Key? key})
      : super(key: key);

  final PaymentOption selectedOption;
  final PaymentOption paymentOption;
  final Function(PaymentOption)? onChanged;

  @override
  Widget build(BuildContext context) {
    String optionText =
        '${paymentOption.number} x ${nf.format(paymentOption.value)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RadioListTile<PaymentOption>(
          title: Text(optionText),
          secondary: Text(nf.format(paymentOption.total)),
          value: paymentOption,
          groupValue: selectedOption,
          onChanged: (value) => onChanged?.call(value!),
        ),
      ),
    );
  }
}
