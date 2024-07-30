import '../../domain/domain.dart';

class BookAppointmentParamModel {
  final int specialtyId;
  final int professionalId;
  final bool video;
  final DateTime date;
  final String name;
  final double value;

  BookAppointmentParamModel({
    required this.specialtyId,
    required this.professionalId,
    required this.video,
    required this.date,
    required this.name,
    required this.value,
  });

  factory BookAppointmentParamModel.fromParam(BookAppointmentParam param) =>
      BookAppointmentParamModel(
        specialtyId: param.specialtyId,
        professionalId: param.professionalId,
        video: param.video,
        date: param.date,
        name: param.name,
        value: param.value,
      );

  Map toMap() => {
        "specialty_id": specialtyId,
        "professional_id": professionalId,
        "video": video,
        "date": date.toIso8601String(),
        "name": name,
      };
}
