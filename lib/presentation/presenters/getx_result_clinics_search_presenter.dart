import 'package:get/get.dart';

import '../../presentation/presentation.dart';
import '../../ui/pages/pages.dart';

class GetxResultClinicsSearchPresenter extends GetxController
    with NavigationManager
    implements SearchResultClinicsPresenter {
  @override
  void goToClinicPage(int idClinic) {
    navigateTo = '/clinic/$idClinic';
  }
}
