import 'package:medislot/domain/domain.dart';

abstract class GetSpecialtyByIdUsecase {
  Future<SpecialityEntity> call(int id);
}
