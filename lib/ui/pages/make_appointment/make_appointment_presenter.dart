import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../../ui/ui.dart';

abstract class MakeAppointmentPresenter implements Listenable {
  Stream<String?> get navigateToStream;

  Stream<bool> get isLoadingStream;
  Stream<bool> get isLoadingBookAppointmentStream;
  Stream<bool> get isLoadingPaymentCheckoutStream;
  Stream<bool> get isLoadingProfessionalSlotsStream;

  Stream<UIError?> get mainErrorStream;

  Stream<bool> get isSessionExpiredStream;

  Stream<ClinicEntity?> get clinicStream;
  Stream<List<String>> get professionalSlots;

  Future<void> loadClinic();
  Future<void> getAvailableSlots(String professionalId, DateTime date);

  Future<PaymentCheckoutModel> makeAppointment(BookAppointmentParam param);
  Future<bool> bookAppointment(BookAppointmentParam param);
}
