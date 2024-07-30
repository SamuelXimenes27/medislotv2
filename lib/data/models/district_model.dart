import '../../domain/domain.dart';

class DistrictModel {
  final int id;
  final String name;

  const DistrictModel({required this.id, required this.name});

  factory DistrictModel.fromJson(Map json) => DistrictModel(id: json['id'], name: json['name']);

  DistrictEntity toEntity() => DistrictEntity(id: id, name: name);
}
