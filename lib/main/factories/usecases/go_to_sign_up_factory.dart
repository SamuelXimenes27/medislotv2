import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GoToSignUpUsecase makeGoToSignUpFactory() =>
    RemoteGoToSignUpUsecase(urlLauncherClient: makeUrlLauncherClientFactory(), url: makeUrlSignUpFactory());
