import '../../domain/domain.dart';

class ReviewModel {
  final int? id;
  final int? userId;
  final int? appointmentId;
  final int? clinicId;
  final int? rating;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  const ReviewModel({
    this.id,
    this.userId,
    this.appointmentId,
    this.clinicId,
    this.rating,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map json) => ReviewModel(
        id: json['id'],
        userId: json['userId'],
        appointmentId: json['appointmentId'],
        clinicId: json['clinicId'],
        createdAt: json['createAt'],
        message: json['message'],
        rating: json['rating'],
        updatedAt: json['updatedAt'],
      );

  ReviewEntity toEntity() => ReviewEntity(
      id: id,
      userId: userId,
      appointmentId: appointmentId,
      clinicId: clinicId,
      rating: rating,
      message: message,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
