import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
      secureStorageClient: makeLocalSaveCurrentAccount(),
      goToSignUpUsecase: makeGoToSignUpFactory(),
      goToForgotPasswordUsecase: makeGoToForgotPasswordFactory(),
    );
