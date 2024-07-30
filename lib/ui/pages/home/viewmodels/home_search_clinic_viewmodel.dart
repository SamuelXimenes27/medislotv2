import 'package:equatable/equatable.dart';

class HomeSearchClinicViewmodel extends Equatable {
  final int id;
  final String name;
  final String city;
  final String district;
  final double? rating;
  final String image;

  const HomeSearchClinicViewmodel({
    required this.id,
    required this.name,
    required this.city,
    required this.district,
    required this.rating,
    required this.image,
  });

  factory HomeSearchClinicViewmodel.fromJson(Map json) {
    return HomeSearchClinicViewmodel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      district: json['district'],
      rating: json['rating'],
      image: json['image'],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "district": district,
      "rating": rating,
      "image": image,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        city,
        district,
        rating,
        image,
      ];
}
