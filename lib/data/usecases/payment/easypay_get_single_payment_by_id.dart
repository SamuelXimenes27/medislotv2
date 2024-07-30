import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class EasypayGetSinglePaymentById implements GetSinglePaymentByIdUsecase {
  final HttpClient httpClient;
  final String url;

  EasypayGetSinglePaymentById({required this.httpClient, required this.url});

  @override
  Future<SinglePaymentEntity> call(String id) async {
    try {
      final httpResponse = await httpClient.request(url: '$url/$id', method: HttpMethods.get);
      final responseDecoded = jsonDecode(httpResponse);
      return SinglePaymentModel.fromJson(responseDecoded).toEntity();
    } catch (_) {
      rethrow;
    }
  }
}
