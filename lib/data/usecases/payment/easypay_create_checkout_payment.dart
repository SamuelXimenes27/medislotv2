import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class EasypayCreateCheckoutPayment implements CreateCheckoutPaymentUsecase {
  final HttpClient httpClient;
  final String url;

  EasypayCreateCheckoutPayment({
    required this.httpClient,
    required this.url,
  });
  @override
  Future<PaymentCheckoutEntity> call(CreateCheckoutParams param) async {
    try {
      final body = CreateCheckoutParamsModel.fromDomain(param).toJson();
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.post, body: body);
      final decodedResponse = jsonDecode(httpResponse);
      return PaymentCheckoutModel.fromJson(decodedResponse).toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
