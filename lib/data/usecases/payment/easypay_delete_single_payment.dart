import '../../../data/data.dart';
import '../../../domain/domain.dart';

class EasypayDeleteSinglePayment implements DeleteSinglePaymentUsecase {
  final HttpClient httpClient;
  final String url;

  EasypayDeleteSinglePayment({required this.httpClient, required this.url});

  @override
  Future<void> call(String id) async {
    try {
      await httpClient.request(url: '$url/$id', method: HttpMethods.del);
    } catch (_) {
      rethrow;
    }
  }
}
