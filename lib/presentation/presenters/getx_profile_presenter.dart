import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxProfilePresenter extends GetxController
    with SessionManager, LoadingManager, NavigationManager
    implements ProfilePresenter {
  GetxProfilePresenter({
    required this.getProfileUsecase,
    required this.goToChangePasswordUsecase,
    required this.saveLanguageUsecase,
    required this.loadCurrentLanguageUsecase,
  });

  final GetProfileUsecase getProfileUsecase;
  final GoToChangePasswordUsecase goToChangePasswordUsecase;
  final SaveLanguageUsecase saveLanguageUsecase;
  final LoadCurrentLanguageUsecase loadCurrentLanguageUsecase;

  final _profile = Rx<ProfileViewModel?>(null);

  final _language = Rx<LanguageOption?>(null);

  @override
  Stream<ProfileViewModel?> get profileStream => _profile.stream;

  @override
  Stream<LanguageOption?> get currentLanguage => _language.stream;

  @override
  Future<void> loadPage() async {
    try {
      isLoading = true;

      await _loadCurrentLanguage();

      final response = await getProfileUsecase.get();
      _profile.value = ProfileViewModel(
        name: response.name,
        email: response.email,
        phone: response.phone,
      );
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _profile.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> goToChangePassword() async {
    await goToChangePasswordUsecase();
  }

  @override
  Future<void> changeLanguage(LanguageOption locale) async {
    await saveLanguageUsecase(locale.description);
    navigateTo = '/';
  }

  Future<void> _loadCurrentLanguage() async {
    final currentLanguage = await loadCurrentLanguageUsecase();

    switch (currentLanguage.toLowerCase()) {
      case 'en_us':
        _language.value = LanguageOption.enUs;
        break;
      case 'pt_br':
        _language.value = LanguageOption.ptBr;
        break;
      default:
        _language.value = LanguageOption.fr;
        break;
    }
  }
}
