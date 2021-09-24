import 'dart:convert';

import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:http/http.dart';

class PaymentOptionsRestService {
  final paymentOptionsUrl =
      Uri.parse('https://dreamy-allen-2e1b47.netlify.app/payment-options.json');

  Future<List<PaymentOption>> fetchPaymentOptions() async {
    final Response response = await get(paymentOptionsUrl);

    if (response.statusCode != 200) {
      throw Exception('Error while fetching payment options');
    }

    return List.from(jsonDecode(response.body)['options']['installments']
        .map((optionJson) => PaymentOption.fromJson(optionJson)));
  }
}
