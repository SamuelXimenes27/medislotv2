import '../../domain/domain.dart';

class InsurerModel {
  final int id;
  final String name;

  const InsurerModel({required this.id, required this.name});

  factory InsurerModel.fromJson(Map json) => InsurerModel(id: json['id'], name: json['name']);

  InsurerEntity toEntity() => InsurerEntity(id: id, name: name);
}
