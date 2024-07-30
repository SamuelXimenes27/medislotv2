import 'package:equatable/equatable.dart';
import 'package:medislot/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String password;
  final String deviceName;

  const AuthenticationParams({required this.email, required this.password, required this.deviceName});

  @override
  List<Object?> get props => [email, password, deviceName];
}
