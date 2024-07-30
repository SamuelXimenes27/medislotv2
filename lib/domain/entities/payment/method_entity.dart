class PaymentMethodEntity {
  final String type;
  final String status;
  final String? entity;
  final String? reference;
  final String? url;
  final String? iban;

  PaymentMethodEntity({
    required this.type,
    required this.status,
    required this.entity,
    required this.reference,
    required this.url,
    required this.iban,
  });
}
