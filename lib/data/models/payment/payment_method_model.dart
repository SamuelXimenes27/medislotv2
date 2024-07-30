import '../../../domain/domain.dart';

class PaymentMethodModel {
  final String type;
  final String status;
  final String? entity;
  final String? reference;
  final String? url;
  final String? iban;

  PaymentMethodModel({
    required this.type,
    required this.status,
    required this.entity,
    required this.reference,
    required this.url,
    required this.iban,
  });

  factory PaymentMethodModel.fromJson(Map json) => PaymentMethodModel(
        type: json['type'],
        status: json['status'],
        entity: json['entity'],
        reference: json['reference'],
        url: json['url'],
        iban: json['iban'],
      );

  PaymentMethodEntity toEntity() => PaymentMethodEntity(
        type: type,
        status: status,
        entity: entity,
        reference: reference,
        url: url,
        iban: iban,
      );
}
