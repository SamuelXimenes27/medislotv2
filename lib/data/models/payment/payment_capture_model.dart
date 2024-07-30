import '../../../data/data.dart';
import '../../../domain/domain.dart';

class PaymentCaptureModel {
  final String transactionKey;
  final String descriptive;
  final PaymentAccountModel account;

  PaymentCaptureModel({
    required this.transactionKey,
    required this.descriptive,
    required this.account,
  });

  factory PaymentCaptureModel.toModel(PaymentCaptureEntity entity) => PaymentCaptureModel(
        account: PaymentAccountModel.toModel(entity.account),
        descriptive: entity.descriptive,
        transactionKey: entity.transactionKey,
      );

  Map toMap() => {
        "transaction_key": transactionKey,
        "descriptive": descriptive,
        "account": account.toMap(),
      };
}
