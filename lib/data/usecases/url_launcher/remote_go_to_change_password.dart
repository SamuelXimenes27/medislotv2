import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGoToChangePassword implements GoToChangePasswordUsecase {
  final UrlLauncherClient urlLauncherClient;
  final String url;

  RemoteGoToChangePassword({required this.urlLauncherClient, required this.url});

  @override
  Future<void> call() async {
    try {
      return await urlLauncherClient.request(url: url, urlLauncherTo: UrlLauncherTo.linkUrl);
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
