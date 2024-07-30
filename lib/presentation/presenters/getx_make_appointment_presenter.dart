import 'dart:developer';

import 'package:get/get.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

mixin LoadingBookAppointmentManager on GetxController {
  final _isLoading = false.obs;
  Stream<bool> get isLoadingBookAppointmentStream => _isLoading.stream;
  set isLoadingBookAppointment(bool value) => _isLoading.value = value;
}

mixin LoadingPaymentCheckoutManager on GetxController {
  final _isLoading = false.obs;
  Stream<bool> get isLoadingPaymentCheckoutStream => _isLoading.stream;
  set isLoadingPaymentCheckout(bool value) => _isLoading.value = value;
}

mixin LoadingProfessionalSlotsManager on GetxController {
  final _isLoading = false.obs;
  Stream<bool> get isLoadingProfessionalSlotsStream => _isLoading.stream;
  set isLoadingProfessionalSlots(bool value) => _isLoading.value = value;
}

class GetxMakeAppointmentPresenter extends GetxController
    with
        NavigationManager,
        SessionManager,
        LoadingManager,
        LoadingBookAppointmentManager,
        LoadingPaymentCheckoutManager,
        LoadingProfessionalSlotsManager,
        UIErrorManager
    implements MakeAppointmentPresenter {
  GetxMakeAppointmentPresenter({
    required this.getClinic,
    required this.checkoutPaymentUsecase,
    required this.getProfileUsecase,
    required this.bookAppoimentUsecase,
    required this.getProfessionalSlotsUsecase,
    required this.cancelAppointmentUsecase,
  });

  final GetClinic getClinic;
  final CreateCheckoutPaymentUsecase checkoutPaymentUsecase;
  final GetProfileUsecase getProfileUsecase;
  final BookAppoimentUsecase bookAppoimentUsecase;
  final GetProfessionalSlotsUsecase getProfessionalSlotsUsecase;
  final CancelAppointmentUsecase cancelAppointmentUsecase;

  final _clinic = Rx<ClinicEntity?>(null);
  final _professionalSlots = Rx<List<String>>([]);

  String userName = '';

  @override
  Stream<ClinicEntity?> get clinicStream => _clinic.stream;

  @override
  Stream<List<String>> get professionalSlots => _professionalSlots.stream;

  @override
  Future<void> loadClinic() async {
    try {
      isLoading = true;

      final response = await getClinic.get();

      _clinic.value = response;
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _clinic.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<PaymentCheckoutModel> makeAppointment(
      BookAppointmentParam param) async {
    try {
      isLoadingPaymentCheckout = true;

      final customer = await _getCustomerData();

      userName = customer.name;

      final creacteCheckoutParams = CreateCheckoutParams(
        type: ['single'],
        payment: _getPaymentData(customer.email),
        order: _getOrderData(customer.email, param),
        customer: customer,
      );

      final checkoutResponse =
          await checkoutPaymentUsecase(creacteCheckoutParams);

      return PaymentCheckoutModel.fromEntity(checkoutResponse);
    } catch (e) {
      _clinic.subject.addError(UIError.unexpected.description);
      rethrow;
    } finally {
      isLoadingPaymentCheckout = false;
    }
  }

  Future<PaymentCustomerEntity> _getCustomerData() async {
    try {
      final userData = await getProfileUsecase.get();

      return PaymentCustomerEntity(
        name: userData.name,
        email: userData.email!,
        phone: userData.phone!,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  CheckoutPaymentOrderParams _getOrderData(
      String userEmail, BookAppointmentParam orderData) {
    final itemAppointment = CheckoutPaymentItemParams(
      key: 'key max 50',
      description: "description max 50",
      quantity: 1,
      value: orderData.value,
    );

    final _items = [itemAppointment];

    return CheckoutPaymentOrderParams(
      items: _items,
      key: 'key order max 50',
      value: orderData.value,
    );
  }

  CheckoutPaymentParams _getPaymentData(String userEmail) {
    final _capture = CheckoutCaptureParams(
      descriptive: '$userEmail appointment capture',
      // transactionKey: 'TransactionKey',
      // account: PaymentAccountEntity(
      //   id: makeEasyPayAccountId(),
      // ),
      // captureDate: _dateTodayString,
      // splits: [split],
    );

    return CheckoutPaymentParams(
      methods: ['mb', 'cc', 'mbw', 'vi'],
      capture: _capture,
      currenry: 'EUR',
      expirationTime: DateTime.now().add(const Duration(minutes: 30)),
      type: 'sale',
    );
  }

  @override
  Future<bool> bookAppointment(BookAppointmentParam param) async {
    mainError = null;
    isLoadingBookAppointment = true;
    log('teste 1');
    try {
      final paramWithUserName = BookAppointmentParam(
        date: param.date,
        name: userName,
        professionalId: param.professionalId,
        specialtyId: param.specialtyId,
        value: param.value,
        video: param.video,
      );
      log('teste 2: $paramWithUserName');

      await bookAppoimentUsecase(paramWithUserName);
      log('teste 3');
      return true;
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.dateInvalid:
          mainError = UIError.invalidDate;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      return false;
    } finally {
      isLoadingBookAppointment = false;
    }
  }

  @override
  Future<void> getAvailableSlots(String professionalId, DateTime date) async {
    try {
      isLoading = true;
      _professionalSlots.value = [];
      final response = await getProfessionalSlotsUsecase(
          professionalId: professionalId, date: date);
      _professionalSlots.value = response;
    } catch (e) {
      _professionalSlots.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }
}
