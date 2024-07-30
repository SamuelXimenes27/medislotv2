import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter extends GetxController
    with NavigationManager
    implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final LoadCurrentLanguageUsecase loadCurrentLanguageUsecase;

  GetxSplashPresenter({
    required this.loadCurrentAccount,
    required this.loadCurrentLanguageUsecase,
  });

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      await _loadLanguage();
      await loadCurrentAccount.load();
      navigateTo = '/home';
    } catch (error) {
      navigateTo = '/login';
    }
  }

  Future<void> _loadLanguage() async {
    final locale = await loadCurrentLanguageUsecase();
    switch (locale.toLowerCase()) {
      case 'en_us':
        R.load(LanguageOption.enUs);
        break;
      case 'pt_br':
        R.load(LanguageOption.ptBr);
        break;
      default:
        R.load(LanguageOption.fr);
        break;
    }
  }

  @override
  Stream<String?> get navigatoToStream => navigateToStream;
}
