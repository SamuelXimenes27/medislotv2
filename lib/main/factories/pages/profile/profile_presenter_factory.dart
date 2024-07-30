import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

ProfilePresenter makeProfilePresenterFactory() => GetxProfilePresenter(
    getProfileUsecase: makeGetProfileUsecaseFactory(),
    goToChangePasswordUsecase: makeGoToChangePasswordUsecaseFactory(),
    saveLanguageUsecase: makeSaveLanguageUsecaseFactory(),
    loadCurrentLanguageUsecase: makeLoadCurrentLanguageUsecaseFactory());
