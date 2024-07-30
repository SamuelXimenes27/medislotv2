import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetProfessionalSlotsUsecase makeGetProfessionalSlotsUsecaseFactory() => RemoteGetProfessionalAvailableSlots(
      httpClient: makeAuthorizeHttpClientDecorator(),
      url: makeApiUrl('slots'),
    );
