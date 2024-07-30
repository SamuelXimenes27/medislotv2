import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHistoryPresenter extends GetxController
    with SessionManager, NavigationManager, LoadingManager, UIErrorManager
    implements HistoryPresenter {
  final GetHistoryUsecase getHistoryUsecase;
  final RateAppointmentUsecase rateAppointmentUsecase;

  final _history = Rx<List<HistoryItemViewmodel>>([]);

  GetxHistoryPresenter({
    required this.getHistoryUsecase,
    required this.rateAppointmentUsecase,
  });

  @override
  Stream<List<HistoryItemViewmodel>> get historyStream => _history.stream;

  @override
  Future<void> loadPage() async {
    try {
      isLoading = true;
      _history.value = [];

      final responseHistory = await getHistoryUsecase();

      _history.value = responseHistory
          .map((e) => HistoryItemViewmodel(
                id: e.id,
                photo: e.photo,
                name: e.professionalName,
                specialty: e.specialtyName,
                address: 'Clínica Faria',
                dateTime: e.dateTime,
                video: e.video,
                rating: e.rating,
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
  Future<void> rateAppointment(RateAppointmentParams params) async {
    try {
      isLoading = true;
      await rateAppointmentUsecase.call(params);
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
}
