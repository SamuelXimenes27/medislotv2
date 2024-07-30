import 'package:medislot/data/url_launcher/url_launcher.dart';
import 'package:medislot/infra/url_launcher/url_launcher_adapter.dart';

UrlLauncherClient makeUrlLauncherClientFactory() => UrlLauncherAdapter();
