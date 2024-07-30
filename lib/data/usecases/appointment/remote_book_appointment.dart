import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteBookAppointment implements BookAppoimentUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteBookAppointment({required this.httpClient, required this.url});

  @override
  Future<void> call(BookAppointmentParam param) async {
    try {
      final body = BookAppointmentParamModel.fromParam(param).toMap();
      await httpClient.request(url: url, method: HttpMethods.post, body: body);
    } catch (error) {
      throw error == HttpError.badRequest
          ? DomainError.dateInvalid
          : DomainError.unexpected;
    }
  }
}
