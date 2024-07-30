import 'package:medislot/domain/entities/payment/payment.dart';

abstract class GetSinglePaymentByIdUsecase {
  Future<SinglePaymentEntity> call(String id);
}
