import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetProfileUsecase makeGetProfileUsecaseFactory() =>
    RemoteGetProfileUsecase(httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('profile'));
