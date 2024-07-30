import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetFeaturedClinic implements GetFeaturedClinic {
  final HttpClient httpClient;
  final String url;

  RemoteGetFeaturedClinic({required this.httpClient, required this.url});

  @override
  Future<List<ClinicEntity>> call() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);
      return (decodedResponse as List).map((e) => ClinicModel.fromJson(e).toEntity()).toList();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
