class PaymentCheckoutEntity {
  final String id;
  final String session;
  final String? config;

  PaymentCheckoutEntity({
    required this.id,
    required this.session,
    required this.config,
  });
}
