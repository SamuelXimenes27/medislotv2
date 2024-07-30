import '../../domain/domain.dart';

class CityModel {
  final int id;
  final String name;

  CityModel(this.id, this.name);

  factory CityModel.fromJson(Map json) {
    return CityModel(json['id'], json['name']);
  }

  CityEntity toEntity() => CityEntity(id: id, name: name);
}
