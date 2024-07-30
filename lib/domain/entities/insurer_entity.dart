import 'package:equatable/equatable.dart';

class InsurerEntity extends Equatable {
  final int id;
  final String name;

  const InsurerEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
