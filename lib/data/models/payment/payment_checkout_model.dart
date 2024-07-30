import '../../../domain/domain.dart';

class PaymentCheckoutModel {
  final String id;
  final String session;
  final String? config;

  PaymentCheckoutModel({required this.id, required this.session, required this.config});

  factory PaymentCheckoutModel.fromJson(Map json) => PaymentCheckoutModel(
        id: json['id'],
        session: json['session'],
        config: json['config'],
      );

  factory PaymentCheckoutModel.fromEntity(PaymentCheckoutEntity entity) => PaymentCheckoutModel(
        id: entity.id,
        session: entity.session,
        config: entity.config,
      );

  Map toMap() => {
        'id': id,
        'session': session,
        'config': config,
      };

  PaymentCheckoutEntity toEntity() => PaymentCheckoutEntity(id: id, session: session, config: config);
}
