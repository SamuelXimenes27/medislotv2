import 'package:medislot/domain/domain.dart';

abstract class GetClinic {
  Future<ClinicEntity> get();
}
