import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteRateAppointment implements RateAppointmentUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteRateAppointment({required this.httpClient, required this.url});

  @override
  Future<void> call(RateAppointmentParams params) async {
    try {
      final body = RateAppointmentParamModel.fromParam(params).toMap();
      await httpClient.request(url: '$url/${params.appointmentId}', method: HttpMethods.post, body: body);
    } catch (error) {
      throw error == HttpError.badRequest ? DomainError.dateInvalid : DomainError.unexpected;
    }
  }
}
