import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../../ui/ui.dart';

abstract class HomePresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSearchLoadingStream;

  Stream<UIError?> get mainErrorStream;

  Stream<bool> get isSessionExpiredStream;

  Stream<List<SpecialityModel>> get specialitiesStream;

  Stream<List<CityModel>> get citiesStream;
  Stream<List<ClinicEntity>> get featuredClinicStream;
  Stream<List<HomeSearchClinicViewmodel>> get searchClinicsStream;
  Stream<HomeProfileViewmodel?> get profileStream;

  Stream<String?> get navigateToStream;

  Future<void> loadHomePage();
  Future<void> searchClinics(SearchClinicsParams params);
  Future<void> logout();

  void goToClinic(String clinicId);
  void goToPrivacyPolicyPage();
}
