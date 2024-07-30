import 'package:medislot/domain/domain.dart';

abstract class GetFeaturedClinic {
  Future<List<ClinicEntity>> call();
}
