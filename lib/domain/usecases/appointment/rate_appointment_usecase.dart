import 'package:equatable/equatable.dart';

abstract class RateAppointmentUsecase {
  Future<void> call(RateAppointmentParams params);
}

class RateAppointmentParams extends Equatable {
  final int appointmentId;
  final double rating;
  final String? message;

  const RateAppointmentParams({required this.appointmentId, required this.rating, this.message});

  @override
  List<Object?> get props => [appointmentId, rating, message];
}
