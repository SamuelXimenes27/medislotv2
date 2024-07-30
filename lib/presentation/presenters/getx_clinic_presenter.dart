import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxClinicPresenter extends GetxController
    with SessionManager, LoadingManager, NavigationManager
    implements ClinicPresenter {
  final GetClinic getClinic;
  final GoToGoogleMapsUsecase goToGoogleMapsUsecase;
  final GoToPhoneUsecase goToPhoneUsecase;

  GetxClinicPresenter({
    required this.getClinic,
    required this.goToGoogleMapsUsecase,
    required this.goToPhoneUsecase,
  });

  final _clinic = Rx<ClinicEntity?>(null);

  @override
  Stream<ClinicEntity?> get clinicStream => _clinic.stream;

  @override
  Future<void> loadClinic() async {
    try {
      isLoading = true;

      final response = await getClinic.get();

      _clinic.value = response;
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _clinic.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> goToGoogleMaps() async {
    try {
      final address = _clinic.value?.address!.replaceAll(' ', '+');

      await goToGoogleMapsUsecase(address!);
    } on Exception catch (_) {
      _clinic.subject.addError(UIError.unexpected.description);
    }
  }

  @override
  Future<void> goToPhone() async {
    try {
      final _phone = _clinic.value!.phone;
      await goToPhoneUsecase(_phone!);
    } on Exception catch (_) {
      _clinic.subject.addError(UIError.unexpected.description);
    }
  }

  @override
  void makeAppointment() {
    navigateTo = '/makeAppointment/${_clinic.value!.id}';
  }
}
