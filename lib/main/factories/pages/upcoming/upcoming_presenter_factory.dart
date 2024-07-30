import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

UpcomingPresenter makeUpcomingPresenterFactory() => GetxUpcomingPresenter(
      getUpcomingAppointmentsUsecase: makeGetUpcomingAppointmetsFactory(),
    );
