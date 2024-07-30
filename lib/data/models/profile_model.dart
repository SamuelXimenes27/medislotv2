import '../../domain/domain.dart';

class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String? birthdate;
  final String? address;
  final String? districtId;
  final String? cityId;
  final String? citizenId;
  final String? healthId;
  final String? tin;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.address,
    required this.districtId,
    required this.cityId,
    required this.citizenId,
    required this.healthId,
    required this.tin,
  });

  factory ProfileModel.fromJson(Map json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      birthdate: json['birthdate'],
      address: json['address'],
      districtId: json['district_id'],
      cityId: json['city_id'],
      citizenId: json['citizen_id'],
      healthId: json['health_id'],
      tin: json['tin'],
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      email: email,
      phone: phone,
      birthdate: birthdate,
      address: address,
      districtId: districtId,
      cityId: cityId,
      citizenId: citizenId,
      healthId: healthId,
      tin: tin,
    );
  }
}
