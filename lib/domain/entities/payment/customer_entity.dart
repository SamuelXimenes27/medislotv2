class PaymentCustomerEntity {
  final String name;
  final String email;
  final String phone;
  final String? phoneIndicative;
  final String? fiscalNumber;
  final String? key;

  PaymentCustomerEntity({
    required this.name,
    required this.email,
    required this.phone,
    this.phoneIndicative,
    this.fiscalNumber,
    this.key,
  });
}
