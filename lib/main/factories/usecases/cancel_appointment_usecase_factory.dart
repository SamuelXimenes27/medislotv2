import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

CancelAppointmentUsecase makeCancelAppoitmentUsecaseFactory() => RemoteCancelAppointment(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl('cancel'),
    );
