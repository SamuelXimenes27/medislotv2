import '../../../domain/domain.dart';
import '../../data.dart';

class PaymentCreateSinglePaymentModel {
  final String key;
  final double value;
  final String method;
  final String type;
  final PaymentCaptureModel capture;
  final PaymentCustomerModel customer;

  PaymentCreateSinglePaymentModel({
    required this.key,
    required this.value,
    required this.method,
    required this.type,
    required this.capture,
    required this.customer,
  });

  factory PaymentCreateSinglePaymentModel.toModel(PaymentCreateSinglePaymentEntity entity) {
    return PaymentCreateSinglePaymentModel(
      key: entity.key,
      value: entity.value,
      method: entity.method,
      type: entity.type,
      capture: PaymentCaptureModel.toModel(entity.capture),
      customer: PaymentCustomerModel.toModel(entity.customer),
    );
  }

  Map toMap() => {
        "key": key,
        "value": value,
        "type": type,
        "method": method,
        "capture": capture.toMap(),
        "customer": customer.toMap(),
      };
}
