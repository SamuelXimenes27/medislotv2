import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetClinic makeGetClinicByIdFactory(String id) =>
    RemoteGetClinicById(httpClient: makeHttpAdapter(), url: makeApiUrl('clinic/$id'));
