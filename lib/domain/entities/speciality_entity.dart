import 'package:equatable/equatable.dart';

class SpecialityEntity extends Equatable {
  final int id;
  final String name;
  final int? duration;
  final String? price;
  final bool? video;

  const SpecialityEntity({required this.id, required this.name, this.duration, this.price, this.video});

  @override
  List<Object?> get props => [id, name, duration, price, video];
}
