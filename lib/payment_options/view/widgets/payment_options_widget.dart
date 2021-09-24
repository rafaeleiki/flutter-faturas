import 'package:faturas/payment_options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:faturas/shared/model/payment_option/payment_option.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

NumberFormat nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PaymentOptionsWidget extends StatelessWidget {
  const PaymentOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.select(
          (PaymentOptionsViewModel vm) => vm,
    );

    TextStyle? boldTextStyle = Theme
        .of(context)
        .textTheme
        .bodyText1;
    double operationCost = vm.operationCost;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Pagamento da fatura',
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        key: const Key('payment_options_container'),
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
              child: FutureBuilder<List<PaymentOption>>(
                future: vm.paymentOptions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final paymentOptions = snapshot.data!;

                    return ListView.builder(
                      itemCount: paymentOptions.length,
                      itemBuilder: (context, index) {
                        return PaymentPortionItem(
                          selectedOption: vm.selectedOption,
                          onChanged: (value) => vm.selectedOption = value,
                          paymentOption: paymentOptions[index],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(child: CircularProgressIndicator());
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
                          Text(nf.format(
                              vm.selectedOption != null ?
                              vm.selectedOption!.total : 0)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Taxa da operação'),
                        const Spacer(),
                        Text(
                          nf.format(operationCost),
                          key: const Key('operation_cost'),
                        ),
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
  const PaymentPortionItem({required this.selectedOption,
    required this.paymentOption,
    this.onChanged,
    Key? key})
      : super(key: key);

  final PaymentOption? selectedOption;
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
          key: Key('payment_option_${paymentOption.number}'),
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
