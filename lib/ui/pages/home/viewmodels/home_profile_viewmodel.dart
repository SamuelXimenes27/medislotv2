import 'package:equatable/equatable.dart';

class HomeProfileViewmodel extends Equatable {
  final String name;

  const HomeProfileViewmodel({required this.name});

  @override
  List<Object?> get props => [name];
}
