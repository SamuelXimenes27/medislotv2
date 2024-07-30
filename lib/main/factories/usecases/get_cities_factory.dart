import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetCities makeGetCitiesFactory() => RemoteGetCities(httpClient: makeHttpAdapter(), url: makeApiUrl('cities'));
