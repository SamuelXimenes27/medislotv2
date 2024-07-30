import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetClinicById implements GetClinic {
  final HttpClient httpClient;
  final String url;

  RemoteGetClinicById({required this.httpClient, required this.url});

  @override
  Future<ClinicEntity> get() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: HttpMethods.get);
      final decodedREsponde = jsonDecode(httpResponse);
      return ClinicModel.fromJson(decodedREsponde).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
