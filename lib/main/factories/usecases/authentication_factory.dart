import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

Authentication makeRemoteAuthentication() =>
    RemoteAuthentication(httpClient: makeHttpAdapter(), url: makeApiUrl('auth/token'));
