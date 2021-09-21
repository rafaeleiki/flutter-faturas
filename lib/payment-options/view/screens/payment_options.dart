import 'package:flutter/material.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({Key? key}) : super(key: key);

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
            const PaymentPortionList(),
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
                    SizedBox(height: 16),
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
                    onPressed: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Voltar'),
                    )),
                Text('1 de 3'),
                ElevatedButton(
                  onPressed: () => {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
  const PaymentPortionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const groupValue = 1;

    return Column(
      children: const [
        PaymentPortionItem(
          portionCount: 1,
          portionValue: 3180.0,
          totalValue: 3180.0,
          groupValue: groupValue,
        ),
        PaymentPortionItem(
          portionCount: 2,
          portionValue: 1630.0,
          totalValue: 3260.0,
          groupValue: groupValue,
        ),
        PaymentPortionItem(
          portionCount: 3,
          portionValue: 1086.67,
          totalValue: 3260.0,
          groupValue: groupValue,
        ),
        PaymentPortionItem(
          portionCount: 4,
          portionValue: 815.0,
          totalValue: 3260.0,
          groupValue: groupValue,
        ),
        PaymentPortionItem(
          portionCount: 5,
          portionValue: 662.0,
          totalValue: 3310.0,
          groupValue: groupValue,
        ),
        PaymentPortionItem(
          portionCount: 6,
          portionValue: 551.67,
          totalValue: 3310.0,
          groupValue: groupValue,
        ),
      ],
    );
  }
}

class PaymentPortionItem extends StatelessWidget {
  const PaymentPortionItem(
      {required this.groupValue,
      required this.portionCount,
      required this.portionValue,
      required this.totalValue,
      Key? key})
      : super(key: key);

  final int groupValue;
  final int portionCount;
  final double portionValue;
  final double totalValue;

  String _toCurrency(double value) =>
      'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RadioListTile(
          title: Text('$portionCount x R\$ ${_toCurrency(portionValue)}'),
          secondary: Text(_toCurrency(totalValue)),
          value: portionCount,
          groupValue: groupValue,
          onChanged: (int? value) => {},
        ),
      ),
    );
  }
}
