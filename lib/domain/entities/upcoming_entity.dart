class AppointmentEntity {
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

  AppointmentEntity({
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
}
