import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

SplashPresenter makeGetxSplashPresenter() => GetxSplashPresenter(
    loadCurrentAccount: makeLocalLoadCurrentAccount(),
    loadCurrentLanguageUsecase: makeLoadCurrentLanguageUsecaseFactory());
