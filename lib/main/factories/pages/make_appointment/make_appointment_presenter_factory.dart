import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

MakeAppointmentPresenter makeAppointmentPresenterFactory(String clinicId) => GetxMakeAppointmentPresenter(
    getClinic: makeGetClinicByIdFactory(clinicId),
    checkoutPaymentUsecase: makeCreateCheckoutPaymentUsecaseFactory(),
    getProfileUsecase: makeGetProfileUsecaseFactory(),
    bookAppoimentUsecase: makeBookAppointmentUsecaseFactory(),
    getProfessionalSlotsUsecase: makeGetProfessionalSlotsUsecaseFactory(),
    cancelAppointmentUsecase: makeCancelAppoitmentUsecaseFactory());
