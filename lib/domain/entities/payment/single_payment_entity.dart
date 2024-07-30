import 'package:medislot/domain/entities/payment/payment.dart';

class SinglePaymentEntity {
  final String id;
  final String type;
  final String key;
  final DateTime expirationTime;
  final PaymentCustomerEntity customer;
  final PaymentMethodEntity method;
  final String currency;
  final double value;
  final DateTime createAt;
  final String paymentStatus;

  SinglePaymentEntity({
    required this.id,
    required this.type,
    required this.key,
    required this.expirationTime,
    required this.customer,
    required this.method,
    required this.currency,
    required this.value,
    required this.createAt,
    required this.paymentStatus,
  });
}
