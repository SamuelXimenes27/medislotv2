import 'package:medislot/lib.dart';

class RateAppointmentParamModel {
  final int appointmentId;
  final double rating;
  final String? message;

  RateAppointmentParamModel({required this.appointmentId, required this.rating, required this.message});

  factory RateAppointmentParamModel.fromParam(RateAppointmentParams param) => RateAppointmentParamModel(
        appointmentId: param.appointmentId,
        rating: param.rating,
        message: param.message,
      );

  Map toMap() => {
        "rating": rating,
        "message": message,
      };
}
