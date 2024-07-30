import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';

abstract class ClinicPresenter implements Listenable {
  Stream<bool> get isLoadingStream;

  Stream<bool> get isSessionExpiredStream;

  Stream<ClinicEntity?> get clinicStream;

  Stream<String?> get navigateToStream;

  Future<void> loadClinic();
  Future<void> goToGoogleMaps();
  Future<void> goToPhone();
  void makeAppointment();
}
