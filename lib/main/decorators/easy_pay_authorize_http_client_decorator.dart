import 'package:medislot/data/data.dart';

class EasyPayAuthorizeHttpClientDecorator implements HttpClient {
  final String accountId;
  final String apiKey;
  final HttpClient decorate;

  EasyPayAuthorizeHttpClientDecorator({
    required this.accountId,
    required this.apiKey,
    required this.decorate,
  });

  @override
  Future request({
    required String url,
    required HttpMethods method,
    Map? body,
    Map? headers,
  }) async {
    try {
      final easyPayAuthorizedHeaders = headers ?? {}
        ..addAll({
          'AccountId': accountId,
          'ApiKey': apiKey,
        });
      return await decorate.request(url: url, method: method, body: body, headers: easyPayAuthorizedHeaders);
    } catch (e) {
      rethrow;
    }
  }
}
