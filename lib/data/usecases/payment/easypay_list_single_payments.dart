import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class EasypayListSinglePayments implements ListSinglePaymentsUsecase {
  final HttpClient httpClient;
  final String url;

  EasypayListSinglePayments({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<SinglePaymentEntity>> call({String page = '1'}) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);
      return (decodedResponse as List).map((e) => SinglePaymentModel.fromJson(e).toEntity()).toList();
    } catch (_) {
      rethrow;
    }
  }
}
