import 'package:equatable/equatable.dart';

class UpcomingViewmodel extends Equatable {
  final int clinicId;
  final int upcomingId;
  final String? profressionalPhoto;
  final String name;
  final String specialty;
  final String professionalName;
  final bool video;
  final DateTime dateTime;

  const UpcomingViewmodel({
    required this.clinicId,
    required this.upcomingId,
    required this.profressionalPhoto,
    required this.name,
    required this.specialty,
    required this.professionalName,
    required this.video,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [];
}
