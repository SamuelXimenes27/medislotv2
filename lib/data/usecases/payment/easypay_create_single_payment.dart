import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class EasypayCreateSinglePayment implements CreateSinglePaymentUsecase {
  final HttpClient httpClient;
  final String url;

  EasypayCreateSinglePayment({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<String> call(PaymentCreateSinglePaymentEntity value) async {
    try {
      final body = PaymentCreateSinglePaymentModel.toModel(value).toMap();
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.post, body: body);
      final decodedResponse = jsonDecode(httpResponse);
      return decodedResponse['customer']['id'];
    } catch (_) {
      rethrow;
    }
  }
}
