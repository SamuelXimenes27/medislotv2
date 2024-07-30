import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxUpcomingPresenter extends GetxController
    with UIErrorManager, LoadingManager, NavigationManager, SessionManager
    implements UpcomingPresenter {
  final GetUpcomingAppointmentsUsecase getUpcomingAppointmentsUsecase;

  GetxUpcomingPresenter({required this.getUpcomingAppointmentsUsecase});

  final _upcoming = Rx<List<UpcomingViewmodel>>([]);

  @override
  Stream<List<UpcomingViewmodel>> get upcomingStream => _upcoming.stream;

  @override
  Future<void> loadPage() async {
    try {
      isLoading = true;

      final response = await getUpcomingAppointmentsUsecase();

      _upcoming.value = response
          .map((e) => UpcomingViewmodel(
                upcomingId: e.id,
                profressionalPhoto: e.professionalPhoto,
                name: e.professionalName,
                specialty: e.specialtyName,
                professionalName: e.professionalName,
                video: e.video,
                dateTime: e.datetime,
                clinicId: e.clinicId,
              ))
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        mainError = UIError.unexpected;
        mainError = null;
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void goToClinicPage(int id) {
    navigateTo = '/clinic/$id';
  }

  @override
  void goToVideoCall(int id) {
    navigateTo = '/videocall/$id';
  }
}
