import 'package:flutter/material.dart';

abstract class SearchResultClinicsPresenter implements Listenable {
  Stream<String?> get navigateToStream;

  void goToClinicPage(int idClinic);
}
