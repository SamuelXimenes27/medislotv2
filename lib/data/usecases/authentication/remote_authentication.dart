import 'dart:developer';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      log(url.toString());
      log(body.toString());
      final httpResponse = await httpClient.request(
          url: url, method: HttpMethods.post, body: body);
      return RemoteAccountModel(accessToken: httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
