import 'package:medislot/data/usecases/appointment/remote_rate_appointment.dart';

import '../../../domain/domain.dart';
import '../http/http.dart';

RateAppointmentUsecase makeRateAppointmentUsecaseFactory() => RemoteRateAppointment(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl('rate'),
    );
