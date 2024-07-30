import '../../domain/domain.dart';

class HistoryModel {
  final int id;
  final int patientId;
  final int professionalId;
  final String professionalName;
  final int specialtyId;
  final String specialtyName;
  final int status;
  final bool video;
  final DateTime dateTime;
  final String price;
  final String? coupon;
  final double? rating;
  final String? photo;

  HistoryModel({
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

  factory HistoryModel.fromJson(Map json) {
    return HistoryModel(
        id: json['id'],
        patientId: json['patient_id'],
        professionalId: json['professional_id'],
        professionalName: json['professional_name'],
        specialtyId: json['specialty_id'],
        specialtyName: json['specialty_name'],
        status: json['status'],
        video: json['video'] == 1 ? true : false,
        dateTime: DateTime.parse(json['date']),
        price: json['price'],
        coupon: json['coupon'],
        // ignore: prefer_null_aware_operators
        rating: json['rating'] != null ? json['rating'].toDouble() : null,
        photo: json['photo']);
  }

  HistoryEntity toEntity() => HistoryEntity(
        id: id,
        patientId: patientId,
        professionalId: professionalId,
        professionalName: professionalName,
        specialtyId: specialtyId,
        specialtyName: specialtyName,
        status: intToStatus(status),
        video: video,
        dateTime: dateTime,
        price: price,
        coupon: coupon,
        rating: rating,
        photo: photo,
      );

  HistoryStatus intToStatus(int id) {
    switch (id) {
      case 1:
        return HistoryStatus.pendent;
      case 2:
        return HistoryStatus.confirm;
      case 3:
        return HistoryStatus.conclude;
      case 4:
        return HistoryStatus.carriedOut;
      default:
        return HistoryStatus.canceled;
    }
  }
}
