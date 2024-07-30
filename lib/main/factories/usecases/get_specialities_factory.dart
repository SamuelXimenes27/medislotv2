import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetSpecialities makeGetSpecialities() =>
    RemoteGetSpecialities(httpClient: makeHttpAdapter(), url: makeApiUrl('specialties'));
