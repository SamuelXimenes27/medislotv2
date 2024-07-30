import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetUpcomingAppointmentsUsecase makeGetUpcomingAppointmetsFactory() =>
    RemoteGetUpcomingAppointments(httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('upcoming'));
