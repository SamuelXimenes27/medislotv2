class HistoryEntity {
  final int id;
  final int patientId;
  final int professionalId;
  final String professionalName;
  final int specialtyId;
  final String specialtyName;
  final HistoryStatus status;
  final bool video;
  final DateTime dateTime;
  final String price;
  final String? coupon;
  final double? rating;
  final String? photo;

  HistoryEntity({
    required this.id,
    required this.patientId,
    required this.professionalId,
    required this.professionalName,
    required this.specialtyId,
    required this.specialtyName,
    required this.status,
    required this.video,
    required this.dateTime,
    required this.price,
    required this.coupon,
    required this.rating,
    this.photo,
  });
}

enum HistoryStatus { pendent, confirm, conclude, carriedOut, canceled }
