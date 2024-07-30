import 'package:equatable/equatable.dart';

class ProfileViewModel extends Equatable {
  final String name;
  final String? email;
  final String? phone;

  const ProfileViewModel({required this.name, required this.email, required this.phone});

  @override
  List<Object?> get props => [name, email, phone];
}
