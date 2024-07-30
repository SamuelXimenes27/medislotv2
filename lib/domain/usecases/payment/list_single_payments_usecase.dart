import 'package:medislot/domain/entities/payment/payment.dart';

abstract class ListSinglePaymentsUsecase {
  Future<List<SinglePaymentEntity>> call({String page = '1'});
}
