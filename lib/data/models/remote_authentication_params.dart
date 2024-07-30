import '../../domain/domain.dart';

class RemoteAuthenticationParams {
  final String email;
  final String password;
  final String deviceName;

  RemoteAuthenticationParams({required this.email, required this.password, required this.deviceName});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.password, deviceName: params.deviceName);

  Map toJson() => {'email': email, 'password': password, 'device_name': deviceName};
}
