import 'package:faturas/payment-options/repository/rest/payment_options_rest_service.dart';
import 'package:faturas/payment-options/view/screens/payment_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<PaymentOptionsRestService>(
      PaymentOptionsRestService());
  runApp(Faturas());
}

const defaultTextStyle = TextTheme(
  button: TextStyle(
    color: Colors.lightBlue,
    fontSize: 16.0,
  ),
  bodyText1: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  ),
  bodyText2: TextStyle(
    color: Colors.grey,
    fontSize: 16.0,
  ),
);

class Faturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Faturas',
      home: const Home(),
      theme: ThemeData(
          textTheme: defaultTextStyle,
          buttonBarTheme: const ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
          )),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? boldTextStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Sistema de Faturas',
          textAlign: TextAlign.left,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Última fatura',
                    style: boldTextStyle,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Text('R\$3.025,49', style: boldTextStyle),
                          const Text(
                            'Vencimento 08/07/2019',
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Vencida',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Divider(color: Colors.black),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Formas de Pagamento',
                    style: boldTextStyle,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Boleto Bancário'),
                ),
                const SizedBox(height: 8.0),
                const AppButton(
                  text: 'Copiar código de barras do boleto',
                  key: Key('copy_button'),
                ),
                const SizedBox(height: 8.0),
                const AppButton(
                  text: 'Enivar boleto por email',
                  key: Key('send_boleto_button'),
                ),
                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cartão de Crédito'),
                ),
                const SizedBox(height: 8.0),
                AppButton(
                  text: 'Pagar com cartão de crédito',
                  key: const Key('pay_by_credit_card_button'),
                  onPressed: (context) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentOptionsScreen()),
                    )
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({required this.text, this.onPressed, Key? key})
      : super(key: key);

  final String text;
  final Function? onPressed;

  void _showDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Text('Funcionalidade não implementada'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    TextStyle? buttonTextStyle = Theme.of(context).textTheme.button;
    Function onPressed = this.onPressed ?? _showDialog;

    return OutlinedButton(
        onPressed: () => onPressed(context),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: buttonTextStyle,
          ),
        ));
  }
}
