import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGoToForgotPassword implements GoToForgotPasswordUsecase {
  final UrlLauncherClient urlLauncherClient;
  final String url;

  RemoteGoToForgotPassword({required this.urlLauncherClient, required this.url});

  @override
  Future<void> call() async {
    try {
      return await urlLauncherClient.request(url: url, urlLauncherTo: UrlLauncherTo.linkUrl);
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
