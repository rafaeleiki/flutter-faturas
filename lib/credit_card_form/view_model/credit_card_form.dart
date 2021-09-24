import 'package:faturas/shared/model/credit_card/user_credit_card_model.dart';

class CreditCardFormViewModel {
  final UserCreditCardModel _userCreditCardModel;

  CreditCardFormViewModel(this._userCreditCardModel);

  UserCreditCardModel get userCreditCardModel => _userCreditCardModel;
}