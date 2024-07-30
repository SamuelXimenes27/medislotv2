import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

BookAppoimentUsecase makeBookAppointmentUsecaseFactory() => RemoteBookAppointment(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl('book'),
    );
