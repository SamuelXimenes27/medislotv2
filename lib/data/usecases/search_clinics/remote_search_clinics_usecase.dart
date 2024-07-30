import 'dart:convert';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteSearchClinicUsecase implements SearchClinics {
  final HttpClient httpClient;
  final String url;

  RemoteSearchClinicUsecase({required this.httpClient, required this.url});

  @override
  Future<List<ClinicEntity>> search(SearchClinicsParams param) async {
    final _url = url +
        '?query=${param.citySelected?.name ?? ""}&specialty_id=${param.specialtySelected?.id ?? ""}&date=${_convertDateTimeToString(param.datetime)}';

    try {
      final httpResponse = await httpClient.request(url: _url, method: HttpMethods.get);
      final responseDecoded = jsonDecode(httpResponse);
      return (responseDecoded as List)
          .map((e) => ClinicModel.fromJsonBySearchClinic(e).toEntityBySearchClinic())
          .toList();
    } on HttpError catch (e) {
      throw e == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }

  String? _convertDateTimeToString(DateTime? dateTime) {
    return dateTime == null ? "" : "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
}
