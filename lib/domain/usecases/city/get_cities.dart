import 'package:medislot/domain/domain.dart';

abstract class GetCities {
  Future<List<CityEntity>> call();
}
