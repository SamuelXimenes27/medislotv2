import '../../../domain/domain.dart';

class PaymentAccountModel {
  final String id;

  PaymentAccountModel({
    required this.id,
  });

  factory PaymentAccountModel.toModel(PaymentAccountEntity entity) => PaymentAccountModel(id: entity.id);

  Map toMap() => {
        "id": id,
      };
}
