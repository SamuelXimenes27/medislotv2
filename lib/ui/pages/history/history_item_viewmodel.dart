import 'package:equatable/equatable.dart';

class HistoryItemViewmodel extends Equatable {
  final int id;
  final String? photo;
  final String name;
  final String specialty;
  final String address;
  final DateTime dateTime;
  final bool video;
  final double? rating;

  const HistoryItemViewmodel({
    required this.id,
    required this.photo,
    required this.name,
    required this.specialty,
    required this.address,
    required this.dateTime,
    required this.video,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        photo,
        name,
        specialty,
        address,
        dateTime,
        video,
      ];
}
