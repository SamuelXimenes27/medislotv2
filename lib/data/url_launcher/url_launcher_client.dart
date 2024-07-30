abstract class UrlLauncherClient {
  Future<void> request({
    required String url,
    required UrlLauncherTo urlLauncherTo,
  });
}

enum UrlLauncherTo {
  linkUrl,
  tel,
}
