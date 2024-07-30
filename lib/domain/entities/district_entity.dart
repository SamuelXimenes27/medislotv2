import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  final int id;
  final String name;

  const DistrictEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
