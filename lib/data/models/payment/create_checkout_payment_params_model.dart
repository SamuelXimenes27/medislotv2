import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../../data.dart';

class CreateCheckoutParamsModel {
  final List<String> type;
  final CheckoutPaymentParamsModel payment;
  final CheckoutPaymentOrderParamsModel order;
  final PaymentCustomerModel customer;

  CreateCheckoutParamsModel({
    required this.type,
    required this.payment,
    required this.order,
    required this.customer,
  });

  factory CreateCheckoutParamsModel.fromDomain(CreateCheckoutParams param) => CreateCheckoutParamsModel(
        type: param.type,
        payment: CheckoutPaymentParamsModel.fromDomain(param.payment),
        order: CheckoutPaymentOrderParamsModel.fromDomain(param.order),
        customer: PaymentCustomerModel.toModel(param.customer),
      );

  Map toJson() => {
        "type": type.map((e) => e).toList(),
        "payment": payment.toJson(),
        "order": order.toJson(),
        "customer": customer.toMap(),
      };
}

class CheckoutPaymentParamsModel {
  final String type;
  final List<String> methods;
  final CheckoutCaptureParamsModel capture;
  final DateTime expirationTime;
  final String currenry;

  CheckoutPaymentParamsModel({
    required this.methods,
    required this.type,
    required this.capture,
    required this.expirationTime,
    required this.currenry,
  });

  factory CheckoutPaymentParamsModel.fromDomain(CheckoutPaymentParams param) => CheckoutPaymentParamsModel(
        methods: param.methods,
        type: param.type,
        capture: CheckoutCaptureParamsModel.fromDomain(param.capture),
        expirationTime: param.expirationTime,
        currenry: param.currenry,
      );

  Map toJson() => {
        "methods": methods.toList(),
        "type": type,
        "capture": capture.toJson(),
        "expiration_time": DateFormat("yyyy-MM-dd HH:mm").format(expirationTime),
        "currency": currenry,
      };
}

class CheckoutCaptureParamsModel {
  final String descriptive;

  CheckoutCaptureParamsModel({
    required this.descriptive,
  });

  factory CheckoutCaptureParamsModel.fromDomain(CheckoutCaptureParams param) => CheckoutCaptureParamsModel(
        descriptive: param.descriptive,
      );

  Map toJson() => {
        "descriptive": descriptive,
      };
}

class CheckoutPaymentSplitParamsModel {
  final String splitKey;
  final String splitDescriptive;
  final int value;
  final PaymentAccountModel account;
  final double marginValue;
  final PaymentAccountModel marginAccount;

  CheckoutPaymentSplitParamsModel({
    required this.splitKey,
    required this.splitDescriptive,
    required this.value,
    required this.account,
    required this.marginValue,
    required this.marginAccount,
  });

  factory CheckoutPaymentSplitParamsModel.fromDomain(CheckoutPaymentSplitParams param) =>
      CheckoutPaymentSplitParamsModel(
        account: PaymentAccountModel.toModel(param.account),
        marginAccount: PaymentAccountModel.toModel(param.marginAccount),
        marginValue: param.marginValue,
        splitDescriptive: param.splitDescriptive,
        splitKey: param.splitKey,
        value: param.value,
      );

  Map toJson() => {
        "split_key": splitKey,
        "split_descriptive": splitDescriptive,
        "value": value,
        "account": account.toMap(),
        "margin_value": marginValue,
        "margin_account": marginAccount.toMap(),
      };
}

class CheckoutPaymentMandateParamsModel {
  final String id;
  final String iban;
  final String key;
  final String name;
  final String email;
  final String phone;
  final String accountHolder;
  final String countryCode;
  final String maxNumDebits;

  CheckoutPaymentMandateParamsModel({
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

  factory CheckoutPaymentMandateParamsModel.fromDomain(CheckoutPaymentMandateParams param) =>
      CheckoutPaymentMandateParamsModel(
        accountHolder: param.accountHolder,
        countryCode: param.accountHolder,
        email: param.email,
        iban: param.iban,
        id: param.id,
        key: param.key,
        maxNumDebits: param.maxNumDebits,
        name: param.name,
        phone: param.phone,
      );

  Map toJson() => {
        "id": id,
        "iban": iban,
        "key": key,
        "name": name,
        "email": email,
        "phone": phone,
        "account_holder": accountHolder,
        "country_code": countryCode,
        "max_num_debits": maxNumDebits,
      };
}

class CheckoutPaymentOrderParamsModel {
  final List<CheckoutPaymentItemParamsModel> items;
  final String key;
  final double value;

  CheckoutPaymentOrderParamsModel({
    required this.items,
    required this.key,
    required this.value,
  });

  factory CheckoutPaymentOrderParamsModel.fromDomain(CheckoutPaymentOrderParams param) =>
      CheckoutPaymentOrderParamsModel(
        items: param.items.map((e) => CheckoutPaymentItemParamsModel.fromDomain(e)).toList(),
        key: param.key,
        value: param.value,
      );

  Map toJson() => {
        "items": items.map((e) => e.toJson()).toList(),
        "key": key,
        "value": value,
      };
}

class CheckoutPaymentItemParamsModel {
  final String description;
  final int quantity;
  final String key;
  final double value;

  CheckoutPaymentItemParamsModel({
    required this.description,
    required this.quantity,
    required this.key,
    required this.value,
  });

  factory CheckoutPaymentItemParamsModel.fromDomain(CheckoutPaymentItemParams param) => CheckoutPaymentItemParamsModel(
        description: param.description,
        key: param.key,
        quantity: param.quantity,
        value: param.value,
      );

  Map toJson() => {
        "description": description,
        "quantity": quantity,
        "key": key,
        "value": value,
      };
}
