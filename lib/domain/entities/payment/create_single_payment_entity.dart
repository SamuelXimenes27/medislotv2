import 'package:medislot/domain/entities/payment/payment.dart';

class PaymentCreateSinglePaymentEntity {
  final String key;
  final double value;
  final String method;
  final String type;
  final PaymentCaptureEntity capture;
  final PaymentCustomerEntity customer;

  PaymentCreateSinglePaymentEntity({
    required this.key,
    required this.value,
    required this.method,
    required this.type,
    required this.capture,
    required this.customer,
  });
}
