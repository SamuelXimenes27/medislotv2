import 'package:medislot/domain/entities/profile_entity.dart';

abstract class GetProfileUsecase {
  Future<ProfileEntity> get();
}
