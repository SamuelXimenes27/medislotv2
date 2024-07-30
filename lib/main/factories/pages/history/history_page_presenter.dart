import 'package:medislot/main/factories/usecases/rate_appointment_usecase_factory.dart';

import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

HistoryPresenter makeHistoryPresenterFactory() => GetxHistoryPresenter(
      getHistoryUsecase: makeGetHistoryUsecaseFactory(),
      rateAppointmentUsecase: makeRateAppointmentUsecaseFactory(),
    );
