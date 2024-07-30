import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetSpecialities implements GetSpecialities {
  final HttpClient httpClient;
  final String url;

  RemoteGetSpecialities({required this.httpClient, required this.url});

  @override
  Future<List<SpecialityEntity>> call() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);
      return (decodedResponse as List).map((e) => SpecialityModel.fromJson(e).toEntity()).toList();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
