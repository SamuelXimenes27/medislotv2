import 'package:medislot/domain/entities/payment/create_single_payment_entity.dart';

abstract class CreateSinglePaymentUsecase {
  Future<String> call(PaymentCreateSinglePaymentEntity payment);
}
