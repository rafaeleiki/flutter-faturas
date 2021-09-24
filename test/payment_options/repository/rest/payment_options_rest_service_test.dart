import 'package:faturas/payment_options/repository/rest/payment_options_rest_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'payment_options_rest_service_test.mocks.dart';

const mockedJsonResponse = '''
{
   "options": {
      "convinienceFee": 0.05,
      "convinienceFeeAmount": 227.23,
      "installments": [
         {
            "number": 1,
            "value": 4775,
            "total": 4775,
            "fee": 0,
            "convinience": 230.45
         },
         {
            "number": 2,
            "value": 2447.5,
            "total": 4895,
            "fee": 0.025,
            "convinience": 350.45
         },
         {
            "number": 3,
            "value": 1631.67,
            "total": 4895,
            "fee": 0.025,
            "convinience": 350.45
         },
         {
            "number": 4,
            "value": 1223.75,
            "total": 4895,
            "fee": 0.025,
            "convinience": 350.45
         },
         {
            "number": 5,
            "value": 995,
            "total": 4975,
            "fee": 0.04,
            "convinience": 430.45
         },
         {
            "number": 6,
            "value": 829.17,
            "total": 4975,
            "fee": 0.04,
            "convinience": 430.45
         },
         {
            "number": 7,
            "value": 710.71,
            "total": 4975,
            "fee": 0.04,
            "convinience": 430.45
         },
         {
            "number": 8,
            "value": 631.25,
            "total": 5050,
            "fee": 0.055,
            "convinience": 505.45
         },
         {
            "number": 9,
            "value": 561.11,
            "total": 5050,
            "fee": 0.055,
            "convinience": 505.45
         },
         {
            "number": 10,
            "value": 505,
            "total": 5050,
            "fee": 0.055,
            "convinience": 505.45
         },
         {
            "number": 11,
            "value": 464.09,
            "total": 5105,
            "fee": 0.065,
            "convinience": 560.45
         },
         {
            "number": 12,
            "value": 425.42,
            "total": 5105,
            "fee": 0.065,
            "convinience": 560.45
         }
      ]
   }
}
''';

final getIt = GetIt.instance;

@GenerateMocks([http.Client])
void main() {
  group('PaymentOptionsRestService', () {
    group('fetchPaymentOptions', () {
      late http.Client client;

      setUp(() {
        client = MockClient();
        getIt.registerSingleton<http.Client>(client);
      });

      tearDown(() {
        getIt.unregister<http.Client>(instance: client);
      });

      test('can receive data', () async {
        when(client.get(PaymentOptionsRestService.paymentOptionsUrl))
            .thenAnswer((_) async => http.Response(mockedJsonResponse, 200));

        final service = PaymentOptionsRestService();

        final result = await service.fetchPaymentOptions();

        expect(result.length, 12);
      });

      test('throws exception when a error is found', () {
        when(client.get(PaymentOptionsRestService.paymentOptionsUrl))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final service = PaymentOptionsRestService();

        expect(
            () async => await service.fetchPaymentOptions(), throwsException);
      });
    });
  });
}
