import '../../../data/data.dart';
import '../../../domain/domain.dart';

class RemoteGoToGoogleMaps implements GoToGoogleMapsUsecase {
  final UrlLauncherClient urlLauncherClient;

  RemoteGoToGoogleMaps({required this.urlLauncherClient});

  @override
  Future<void> call(String address) async {
    final _urlGoogleMaps = 'https://www.google.com/maps/search/$address';
    try {
      return await urlLauncherClient.request(url: _urlGoogleMaps, urlLauncherTo: UrlLauncherTo.linkUrl);
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
