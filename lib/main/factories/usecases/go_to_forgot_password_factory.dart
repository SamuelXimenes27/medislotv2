import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GoToForgotPasswordUsecase makeGoToForgotPasswordFactory() =>
    RemoteGoToForgotPassword(urlLauncherClient: makeUrlLauncherClientFactory(), url: makeUrlForgotPasswordFactory());
