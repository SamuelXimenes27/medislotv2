import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int? id;
  final int? userId;
  final int? appointmentId;
  final int? clinicId;
  final int? rating;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  const ReviewEntity({
    this.id,
    this.userId,
    this.appointmentId,
    this.clinicId,
    this.rating,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, appointmentId, clinicId, rating, message, createdAt, updatedAt];
}
