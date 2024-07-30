import 'package:medislot/domain/domain.dart';

abstract class GetSpecialities {
  Future<List<SpecialityEntity>> call();
}
