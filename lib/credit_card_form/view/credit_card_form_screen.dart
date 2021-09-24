import 'package:faturas/credit_card_form/view_model/credit_card_form.dart';
import 'package:faturas/shared/model/credit_card/user_credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreditCardFormScreen extends StatelessWidget {
  const CreditCardFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<UserCreditCardModel, CreditCardFormViewModel>(
      create: (context) =>
          CreditCardFormViewModel(context.read<UserCreditCardModel>()),
      update: (context, userCreditCardModel, notifier) =>
          CreditCardFormViewModel(userCreditCardModel),
      child: const CreditCardFormWidget(),
    );
  }
}

class CreditCardFormWidget extends StatefulWidget {
  const CreditCardFormWidget({Key? key}) : super(key: key);

  @override
  _CreditCardFormWidgetState createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget> {
  late TextEditingController _numberController;
  late TextEditingController _nameController;
  late TextEditingController _expirationController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();

    final vm = context.read<CreditCardFormViewModel>();

    _numberController =
        TextEditingController(text: vm.userCreditCardModel.creditCard.number);
    _numberController.addListener(() => setState(() {
          vm.userCreditCardModel
              .updateCreditCard(number: _numberController.text);
        }));

    _nameController =
        TextEditingController(text: vm.userCreditCardModel.creditCard.name);
    _nameController.addListener(() => setState(() {
          vm.userCreditCardModel.updateCreditCard(name: _nameController.text);
        }));

    _expirationController = TextEditingController(
        text: vm.userCreditCardModel.creditCard.expiration);
    _expirationController.addListener(() => setState(() {
          vm.userCreditCardModel
              .updateCreditCard(expiration: _expirationController.text);
        }));

    _cvvController =
        TextEditingController(text: vm.userCreditCardModel.creditCard.cvv);
    _cvvController.addListener(() => setState(() {
          vm.userCreditCardModel.updateCreditCard(cvv: _cvvController.text);
        }));
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Pagamento da fatura',
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        key: const Key('payment_options_container'),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Número do cartão',
                ),
                maxLength: 16,
                controller: _numberController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome do titular do cartão',
                ),
                controller: _nameController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '09/21',
                        labelText: 'Validade',
                      ),
                      maxLength: 4,
                      controller: _expirationController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '123',
                        labelText: 'CVV',
                      ),
                      maxLength: 3,
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Essa transação é 100% segura e com certificados'
                  ' de segurança que garantem a integridade dos seus dados',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
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
                const Text('2 de 3'),
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
