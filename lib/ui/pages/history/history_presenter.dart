import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../../../ui/pages/pages.dart';
import '../../helpers/errors/ui_error.dart';

abstract class HistoryPresenter implements Listenable {
  Stream<bool> get isLoadingStream;

  Stream<bool> get isSessionExpiredStream;

  Stream<String?> get navigateToStream;

  Stream<UIError?> get mainErrorStream;

  Stream<List<HistoryItemViewmodel>> get historyStream;

  Future<void> loadPage();
  Future<void> rateAppointment(RateAppointmentParams param);
}
