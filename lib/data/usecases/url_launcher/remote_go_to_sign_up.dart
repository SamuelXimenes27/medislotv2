import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGoToSignUpUsecase implements GoToSignUpUsecase {
  final UrlLauncherClient urlLauncherClient;
  final String url;

  RemoteGoToSignUpUsecase({required this.urlLauncherClient, required this.url});

  @override
  Future<void> call() async {
    try {
      return await urlLauncherClient.request(url: url, urlLauncherTo: UrlLauncherTo.linkUrl);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
