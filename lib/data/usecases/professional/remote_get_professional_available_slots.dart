import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGetProfessionalAvailableSlots implements GetProfessionalSlotsUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteGetProfessionalAvailableSlots({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<String>> call({required String professionalId, required DateTime date}) async {
    try {
      List<String> slotsAvailables = [];

      final dateFormat = DateFormat("yyyy-MM-dd").format(date);
      final _url = "$url?professional_id=$professionalId&date=$dateFormat";

      final response = await httpClient.request(url: _url, method: HttpMethods.get);

      final decodedResponse = jsonDecode(response) as List;

      for (var element in decodedResponse) {
        if (element['isAvailable'] == true) {
          final startSplited = element['start'].split('T').last.substring(0, 5);

          slotsAvailables.add(startSplited);
        }
      }

      slotsAvailables.sort((a, b) => int.parse(a.split(':').first).compareTo(int.parse(b.split(':').first)));

      return slotsAvailables;
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
