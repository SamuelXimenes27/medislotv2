import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

ClinicPresenter makeClinicPresenterFactory(String clinicId) => GetxClinicPresenter(
      getClinic: makeGetClinicByIdFactory(clinicId),
      goToGoogleMapsUsecase: makeGoToGoogleMapsFactory(),
      goToPhoneUsecase: makeGoToPhoneUsecaseFactory(),
    );
