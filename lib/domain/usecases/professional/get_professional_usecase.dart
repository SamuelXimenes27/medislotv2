import 'package:medislot/domain/domain.dart';

abstract class GetProfessionalUsecase {
  Future<ProfessionalEntity> call(int id);
}
