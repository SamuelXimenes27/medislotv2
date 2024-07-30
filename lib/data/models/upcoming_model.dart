import '../../domain/domain.dart';

class AppointmentModel {
  final int id;
  final int patientId;
  final int professionalId;
  final String professionalName;
  final int specialtyId;
  final String specialtyName;
  final int status;
  final bool video;
  final DateTime datetime;
  final String price;
  final double? rating;
  final String? professionalPhoto;
  final int clinicId;

  AppointmentModel({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.professionalId,
    required this.specialtyId,
    required this.status,
    required this.video,
    required this.datetime,
    required this.price,
    required this.rating,
    required this.professionalName,
    required this.specialtyName,
    required this.professionalPhoto,
  });

  factory AppointmentModel.fromJson(Map json) {
    return AppointmentModel(
      id: json['id'],
      patientId: json["patient_id"],
      professionalId: json["professional_id"],
      professionalName: json["professional_name"],
      specialtyId: json["specialty_id"],
      specialtyName: json["specialty_name"],
      status: json["status"],
      video: json["video"] == 1 ? true : false,
      datetime: DateTime.parse(json["date"]),
      price: json["price"],
      rating: json["rating"],
      professionalPhoto:
          json['professional_photo'] == '' || json['professional_photo'] == null ? null : json['professional_photo'],
      clinicId: json['clinic_id'],
    );
  }

  AppointmentEntity toEntity() => AppointmentEntity(
        clinicId: clinicId,
        id: id,
        patientId: patientId,
        professionalId: professionalId,
        professionalName: professionalName,
        specialtyId: specialtyId,
        specialtyName: specialtyName,
        status: status,
        video: video,
        datetime: datetime,
        price: price,
        rating: rating,
        professionalPhoto: professionalPhoto,
      );
}
