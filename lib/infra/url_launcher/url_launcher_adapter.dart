import 'package:url_launcher/url_launcher.dart';

import '../../data/data.dart';

class UrlLauncherAdapter implements UrlLauncherClient {
  @override
  Future<void> request({required String url, required UrlLauncherTo urlLauncherTo}) async {
    try {
      if (urlLauncherTo == UrlLauncherTo.linkUrl) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse('tel:$url'));
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
