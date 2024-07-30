import 'dart:convert';
import 'dart:developer';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetProfileUsecase implements GetProfileUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteGetProfileUsecase({required this.httpClient, required this.url});

  @override
  Future<ProfileEntity> get() async {
    try {
      log(url);
      final httpResponse =
          await httpClient.request(url: url, method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);
      log(decodedResponse.toString());
      return ProfileModel.fromJson(decodedResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
