import 'package:medislot/domain/entities/upcoming_entity.dart';

abstract class GetUpcomingAppointmentsUsecase {
  Future<List<AppointmentEntity>> call();
}
