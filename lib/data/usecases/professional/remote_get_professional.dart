import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetProfessional implements GetProfessionalUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteGetProfessional({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<ProfessionalEntity> call(int id) async {
    try {
      final httpResponse = await httpClient.request(url: 'url/$id', method: HttpMethods.get);
      final decodedREsponde = jsonDecode(httpResponse);
      return ProfessionalModel.fromJson(decodedREsponde).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
