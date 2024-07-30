import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

GoToPrivacyPolicyPageUsecase makeGotoPrivacyPolicyPageFactory() =>
    RemoteGoToPrivacyPolicy(urlLauncherClient: makeUrlLauncherClientFactory(), url: makeUrlPrivacyPolicyFactory());
