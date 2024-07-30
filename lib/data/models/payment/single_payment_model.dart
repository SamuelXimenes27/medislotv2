import '../../../data/data.dart';
import '../../../domain/domain.dart';

class SinglePaymentModel {
  final String id;
  final String type;
  final String key;
  final DateTime expirationTime;
  final PaymentCustomerModel customer;
  final PaymentMethodModel method;
  final String currency;
  final double value;
  final DateTime createAt;
  final String paymentStatus;

  SinglePaymentModel({
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

  factory SinglePaymentModel.fromJson(Map json) => SinglePaymentModel(
        id: json['id'],
        type: json['type'],
        key: json['key'],
        expirationTime: DateTime.parse(json['expirationTime']),
        customer: PaymentCustomerModel.fromJson(json['customer']),
        method: PaymentMethodModel.fromJson(json['method']),
        currency: json['currency'],
        value: json['value'],
        createAt: json['createAt'],
        paymentStatus: json['paymentStatus'],
      );

  SinglePaymentEntity toEntity() => SinglePaymentEntity(
      id: id,
      type: type,
      key: key,
      expirationTime: expirationTime,
      customer: customer.toEntity(),
      method: method.toEntity(),
      currency: currency,
      value: value,
      createAt: createAt,
      paymentStatus: paymentStatus);
}
