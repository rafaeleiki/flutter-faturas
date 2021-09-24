import 'package:faturas/shared/model/credit_card/credit_card.dart';
import 'package:flutter/material.dart';

class UserCreditCardModel extends ChangeNotifier {
  CreditCard _creditCard;

  UserCreditCardModel(this._creditCard);

  CreditCard get creditCard => _creditCard;

  set creditCard(creditCard) {
    _creditCard = creditCard;
    notifyListeners();
  }

  void updateCreditCard(
      {String? number, String? cvv, String? name, String? expiration}) {
    number ??= _creditCard.number;
    cvv ??= _creditCard.cvv;
    name ??= _creditCard.name;
    expiration ??= _creditCard.expiration;

    creditCard = CreditCard(
      number: number,
      cvv: cvv,
      name: name,
      expiration: expiration,
    );
  }
}
