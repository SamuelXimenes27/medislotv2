import '../../../domain/domain.dart';
import '../../http/http.dart';

class RemoteCancelAppointment implements CancelAppointmentUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteCancelAppointment({required this.httpClient, required this.url});

  @override
  Future<void> call(String appointmentId) async {
    try {
      await httpClient.request(url: "$url/$appointmentId", method: HttpMethods.post);
    } catch (error) {
      throw error == HttpError.badRequest ? DomainError.dateInvalid : DomainError.unexpected;
    }
  }
}
