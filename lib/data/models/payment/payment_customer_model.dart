import '../../../domain/domain.dart';

class PaymentCustomerModel {
  final String name;
  final String email;
  final String phone;
  final String? phoneIndicative;
  final String? fiscalNumber;
  final String? key;

  PaymentCustomerModel({
    required this.name,
    required this.email,
    required this.phone,
    this.phoneIndicative,
    this.fiscalNumber,
    this.key,
  });

  factory PaymentCustomerModel.fromJson(Map json) => PaymentCustomerModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        phoneIndicative: json['phoneIndicative'],
        fiscalNumber: json['fiscalNumber'],
        key: json['key'],
      );

  factory PaymentCustomerModel.toModel(PaymentCustomerEntity entity) => PaymentCustomerModel(
        email: entity.email,
        fiscalNumber: entity.fiscalNumber,
        key: entity.key,
        name: entity.name,
        phone: entity.phone,
        phoneIndicative: entity.phoneIndicative,
      );

  PaymentCustomerEntity toEntity() => PaymentCustomerEntity(
        name: name,
        email: email,
        phone: phone,
        phoneIndicative: phoneIndicative,
        fiscalNumber: fiscalNumber,
        key: key,
      );

  Map toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "phone_indicative": phoneIndicative,
        "fiscal_number": fiscalNumber,
        "key": key,
      };
}
