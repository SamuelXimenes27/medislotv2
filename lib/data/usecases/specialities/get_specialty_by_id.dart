import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class GetSpecialtyById implements GetSpecialtyByIdUsecase {
  final HttpClient httpClient;
  final String url;

  GetSpecialtyById({required this.httpClient, required this.url});

  @override
  Future<SpecialityEntity> call(int id) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.get);
      final decodedResponse = jsonDecode(httpResponse);

      return SpecialityModel.fromJson(decodedResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
