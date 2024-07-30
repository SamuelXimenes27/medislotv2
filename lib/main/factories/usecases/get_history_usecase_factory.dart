import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GetHistoryUsecase makeGetHistoryUsecaseFactory() =>
    RemoteGetHistory(httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('history'));
