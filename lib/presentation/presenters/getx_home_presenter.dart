import 'dart:convert';

import 'package:get/get.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController
    with SessionManager, LoadingManager, NavigationManager, LoadingSearchButtonManager, UIErrorManager
    implements HomePresenter {
  GetxHomePresenter({
    required this.getSpecialities,
    required this.getCities,
    required this.getFeaturedClinic,
    required this.getSearchClinics,
    required this.getProfileUsecase,
    required this.deleteCurrentAccount,
    required this.goToPrivacyPolicyPageUsecase,
  });

  final GetSpecialities getSpecialities;
  final GetCities getCities;
  final GetFeaturedClinic getFeaturedClinic;
  final SearchClinics getSearchClinics;
  final GetProfileUsecase getProfileUsecase;
  final DeleteCurrentAccount deleteCurrentAccount;
  final GoToPrivacyPolicyPageUsecase goToPrivacyPolicyPageUsecase;

  final _specialities = Rx<List<SpecialityModel>>([]);

  final _cities = Rx<List<CityModel>>([]);
  final _featuredClinic = Rx<List<ClinicEntity>>([]);
  final _searchClinics = Rx<List<HomeSearchClinicViewmodel>>([]);
  final _profile = Rx<HomeProfileViewmodel?>(null);

  @override
  Stream<List<SpecialityModel>> get specialitiesStream => _specialities.stream;

  @override
  Stream<List<CityModel>> get citiesStream => _cities.stream;

  @override
  Stream<List<ClinicEntity>> get featuredClinicStream => _featuredClinic.stream;

  @override
  Stream<List<HomeSearchClinicViewmodel>> get searchClinicsStream => _searchClinics.stream;

  @override
  Stream<HomeProfileViewmodel?> get profileStream => _profile.stream;

  @override
  Future<void> loadHomePage() async {
    try {
      isLoading = true;

      await Future.wait([
        _loadGetCities(),
        _loadGetSpecialities(),
        _loadFeaturedClinics(),
        _loadProfile(),
      ]);
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
  Future<void> searchClinics(SearchClinicsParams params) async {
    try {
      isSearchLoading = true;

      final response = await getSearchClinics.search(params);

      _searchClinics.value = response
          .map((e) => HomeSearchClinicViewmodel(
                id: e.id,
                name: e.name,
                city: e.city!.isNotEmpty ? e.city?.first.name ?? "" : "",
                district: e.district!.isNotEmpty ? e.district?.first.name ?? "" : "",
                image: e.featuredImage ?? "",
                rating: e.rating,
              ))
          .toList();

      final resultMap = _searchClinics.value.map((e) => e.toJson()).toList();

      Get.toNamed('/clinic_search_result', parameters: {'result': jsonEncode(resultMap)});
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _searchClinics.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isSearchLoading = false;
    }
  }

  Future<void> _loadGetSpecialities() async {
    try {
      final response = await getSpecialities();
      _specialities.value = response
          .map((e) => SpecialityModel(
                id: e.id,
                name: e.name,
                duration: e.duration,
                price: e.price,
                video: e.video,
              ))
          .toList();
    } on DomainError catch (_) {
      rethrow;
    }
  }

  Future<void> _loadGetCities() async {
    try {
      final response = await getCities();
      _cities.value = response
          .map((e) => CityModel(
                e.id,
                e.name,
              ))
          .toList();
    } on DomainError catch (_) {
      rethrow;
    }
  }

  Future<void> _loadFeaturedClinics() async {
    try {
      final response = await getFeaturedClinic();
      _featuredClinic.value = response;
    } on DomainError catch (_) {
      rethrow;
    }
  }

  Future<void> _loadProfile() async {
    try {
      final response = await getProfileUsecase.get();
      _profile.value = HomeProfileViewmodel(name: response.name);
    } on DomainError catch (_) {
      rethrow;
    }
  }

  @override
  void goToClinic(String clinicId) {
    navigateTo = '/clinic/$clinicId';
  }

  @override
  Future<void> logout() async {
    await deleteCurrentAccount();
  }

  @override
  void goToPrivacyPolicyPage() async {
    await goToPrivacyPolicyPageUsecase();
  }
}

mixin LoadingSearchButtonManager on GetxController {
  final _isSearchLoading = false.obs;
  Stream<bool> get isSearchLoadingStream => _isSearchLoading.stream;
  set isSearchLoading(bool value) => _isSearchLoading.value = value;
}
