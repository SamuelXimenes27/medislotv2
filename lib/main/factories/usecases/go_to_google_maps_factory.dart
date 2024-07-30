import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GoToGoogleMapsUsecase makeGoToGoogleMapsFactory() =>
    RemoteGoToGoogleMaps(urlLauncherClient: makeUrlLauncherClientFactory());
