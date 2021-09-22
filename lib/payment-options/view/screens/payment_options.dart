import 'package:flutter/material.dart';
import 'package:faturas/payment-options/model/payment_option.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() {
    return _PaymentOptionsScreenState();
  }
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {

  @override
  Widget build(BuildContext context) {
    TextStyle? boldTextStyle = Theme.of(context).textTheme.bodyText1;

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
            PaymentPortionList(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text('Fatura de junho'),
                          Spacer(),
                          Text('R\$3025,49'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Text('Taxa da operação'),
                        Spacer(),
                        Text('R\$154,51'),
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

class PaymentPortionList extends StatelessWidget {
  PaymentPortionList({Key? key}) : super(key: key);

  final List<PaymentOption> _paymentOptions = [
    PaymentOption(1, 3180.0, 3180.0),
    PaymentOption(2, 1630.0, 3260.0),
    PaymentOption(3, 1086.67, 3260.0),
    PaymentOption(4, 815.0, 3260.0),
    PaymentOption(5, 662.0, 3310.0),
    PaymentOption(6, 551.67, 3310.0),
  ];

  @override
  Widget build(BuildContext context) {
    PaymentOption selectedOption = _paymentOptions[0];
    debugPrint(_paymentOptions.length.toString());

    return Expanded(
      child: ListView.builder(
        itemCount: _paymentOptions.length,
        itemBuilder: (context, index) {
          PaymentOption paymentOption = _paymentOptions[index];
          return PaymentPortionItem(
              selectedOption: selectedOption,
              paymentOption: paymentOption,
          );
        },
      ),
    );
  }
}

class PaymentPortionItem extends StatelessWidget {
  const PaymentPortionItem({
    required this.selectedOption,
    required this.paymentOption,
    Key? key}) : super(key: key);

  final PaymentOption selectedOption;
  final PaymentOption paymentOption;

  String _toCurrency(double value) =>
      'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    String optionText = '${paymentOption.number} x R\$ ${_toCurrency(
        paymentOption.value)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RadioListTile<PaymentOption>(
          title: Text(optionText),
          secondary: Text(_toCurrency(paymentOption.total)),
          value: paymentOption,
          groupValue: selectedOption,
          onChanged: (PaymentOption? value) => {},
        ),
      ),
    );
  }
}
