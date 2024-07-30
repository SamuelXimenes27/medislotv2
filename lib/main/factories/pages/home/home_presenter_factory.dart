import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

HomePresenter makeHomePresenter() => GetxHomePresenter(
    getSpecialities: makeGetSpecialities(),
    getCities: makeGetCitiesFactory(),
    getFeaturedClinic: makeGetFeaturedClinics(),
    getSearchClinics: makeRemoteSearchClinics(),
    getProfileUsecase: makeGetProfileUsecaseFactory(),
    deleteCurrentAccount: makeLocalDeleteCurrentAccountFactory(),
    goToPrivacyPolicyPageUsecase: makeGotoPrivacyPolicyPageFactory());
