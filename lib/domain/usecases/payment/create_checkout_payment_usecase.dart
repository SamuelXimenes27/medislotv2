import '../../entities/payment/account_entity.dart';
import '../../entities/payment/create_checkout_entity.dart';
import '../../entities/payment/customer_entity.dart';

abstract class CreateCheckoutPaymentUsecase {
  Future<PaymentCheckoutEntity> call(CreateCheckoutParams param);
}

class CreateCheckoutParams {
  final List<String> type;
  final CheckoutPaymentParams payment;
  final CheckoutPaymentOrderParams order;
  final PaymentCustomerEntity customer;

  CreateCheckoutParams({
    required this.type,
    required this.payment,
    required this.order,
    required this.customer,
  });
}

class CheckoutPaymentParams {
  final List<String> methods;
  final String type;
  final CheckoutCaptureParams capture;
  final String currenry;
  final DateTime expirationTime;
  // final String key;
  // final CheckoutPaymentMandateParams sddMandate;
  // final int maxValue;
  // final int minValue;
  // final bool unlimitedPayments;
  // final String frequency;
  // final int maxCaptures;
  // final DateTime startTime;
  // final bool failover;
  // final bool captureNow;
  // final int retries;

  CheckoutPaymentParams({
    required this.methods,
    required this.type,
    required this.capture,
    required this.expirationTime,
    required this.currenry,
    // required this.key,
    // required this.sddMandate,
    // required this.maxValue,
    // required this.minValue,
    // required this.unlimitedPayments,
    // required this.frequency,
    // required this.maxCaptures,
    // required this.startTime,
    // required this.failover,
    // required this.captureNow,
    // required this.retries,
  });
}

class CheckoutCaptureParams {
  final String descriptive;
  // final String transactionKey;
  // final String captureDate;
  // final PaymentAccountEntity account;
  // final List<CheckoutPaymentSplitParams> splits;

  CheckoutCaptureParams({
    // required this.transactionKey,
    // required this.captureDate,
    // required this.account,
    // required this.splits,
    required this.descriptive,
  });
}

class CheckoutPaymentSplitParams {
  final String splitKey;
  final String splitDescriptive;
  final int value;
  final PaymentAccountEntity account;
  final double marginValue;
  final PaymentAccountEntity marginAccount;

  CheckoutPaymentSplitParams({
    required this.splitKey,
    required this.splitDescriptive,
    required this.value,
    required this.account,
    required this.marginValue,
    required this.marginAccount,
  });
}

class CheckoutPaymentMandateParams {
  final String id;
  final String iban;
  final String key;
  final String name;
  final String email;
  final String phone;
  final String accountHolder;
  final String countryCode;
  final String maxNumDebits;

  CheckoutPaymentMandateParams({
    required this.id,
    required this.iban,
    required this.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.accountHolder,
    required this.countryCode,
    required this.maxNumDebits,
  });
}

class CheckoutPaymentOrderParams {
  final List<CheckoutPaymentItemParams> items;
  final String key;
  final double value;

  CheckoutPaymentOrderParams({
    required this.items,
    required this.key,
    required this.value,
  });
}

class CheckoutPaymentItemParams {
  final String description;
  final int quantity;
  final String key;
  final double value;

  CheckoutPaymentItemParams({
    required this.description,
    required this.quantity,
    required this.key,
    required this.value,
  });
}
