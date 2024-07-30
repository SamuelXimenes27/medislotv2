import 'package:flutter/material.dart';

import '../../../ui/ui.dart';

abstract class UpcomingPresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<String?> get navigateToStream;

  Stream<UIError?> get mainErrorStream;

  Stream<List<UpcomingViewmodel>> get upcomingStream;

  Future<void> loadPage();
  void goToClinicPage(int id);
  void goToVideoCall(int id);
}
