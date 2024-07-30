import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GoToChangePasswordUsecase makeGoToChangePasswordUsecaseFactory() => RemoteGoToChangePassword(
      urlLauncherClient: makeUrlLauncherClientFactory(),
      url: makeUrlChangePasswordFactory(),
    );
