import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

SearchClinics makeRemoteSearchClinics() =>
    RemoteSearchClinicUsecase(httpClient: makeHttpAdapter(), url: makeApiUrl('search-clinics'));
