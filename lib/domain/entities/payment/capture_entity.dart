import 'package:medislot/domain/entities/payment/payment.dart';

class PaymentCaptureEntity {
  final String transactionKey;
  final String descriptive;
  final PaymentAccountEntity account;

  PaymentCaptureEntity({
    required this.transactionKey,
    required this.descriptive,
    required this.account,
  });
}
