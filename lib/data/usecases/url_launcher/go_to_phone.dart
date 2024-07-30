import '../../../data/data.dart';
import '../../../domain/domain.dart';

class GoToPhoneImp implements GoToPhoneUsecase {
  final UrlLauncherClient urlLauncherClient;

  GoToPhoneImp(this.urlLauncherClient);

  @override
  Future<void> call(String phone) async {
    try {
      return await urlLauncherClient.request(url: phone, urlLauncherTo: UrlLauncherTo.tel);
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
