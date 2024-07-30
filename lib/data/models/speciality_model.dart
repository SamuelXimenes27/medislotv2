import '../../domain/domain.dart';

class SpecialityModel {
  final int id;
  final String name;
  final int? duration;
  final String? price;
  final bool? video;

  const SpecialityModel({required this.id, required this.name, this.duration, this.price, this.video});

  factory SpecialityModel.fromJson(Map json) => SpecialityModel(
        id: json['id'],
        name: json['name_pt'] ?? json['name'],
        duration: json['duration'],
        price: json['price'],
        video: json['video'] == 1 ? true : false,
      );

  SpecialityEntity toEntity() => SpecialityEntity(id: id, name: name, duration: duration, price: price, video: video);
}
