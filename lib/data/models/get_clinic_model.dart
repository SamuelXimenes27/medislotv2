import '../../data/data.dart';
import '../../domain/domain.dart';

class ClinicModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? description;
  final String? address;
  final List<DistrictModel>? district;
  final List<CityModel>? city;
  final double? latitude;
  final double? longitude;
  final int? featured;
  final String? featuredImage;
  final double? rating;
  final List<ReviewModel>? reviews;
  final List<List<ScheduleModel>>? schedule;
  final List<SpecialityModel>? specialities;
  final List<InsurerModel>? insurers;
  final List<ProfessionalModel>? professionals;

  ClinicModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.description,
    this.address,
    this.district,
    this.city,
    this.latitude,
    this.longitude,
    this.featured,
    this.featuredImage,
    this.rating,
    this.reviews,
    this.schedule,
    this.specialities,
    this.insurers,
    this.professionals,
  });

  factory ClinicModel.fromJson(Map json) {
    return ClinicModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      description: json['description'],
      address: json['address'],
      district: json['district'].map<DistrictModel>((district) => DistrictModel.fromJson(district)).toList(),
      city: json['city'].map<CityModel>((city) => CityModel.fromJson(city)).toList(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      featured: json['featured'],
      featuredImage: json['featured_image'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'].map<ReviewModel>((review) => ReviewModel.fromJson(review)).toList(),
      schedule: List<List<ScheduleModel>>.from(
          json["schedule"].map((x) => List<ScheduleModel>.from(x.map((x) => ScheduleModel.fromJson(x))))),
      specialities:
          json['specialties'].map<SpecialityModel>((speciality) => SpecialityModel.fromJson(speciality)).toList(),
      insurers: json['insurers'].map<InsurerModel>((insurers) => InsurerModel.fromJson(insurers)).toList(),
      professionals: json['professionals']
          .map<ProfessionalModel>((professional) => ProfessionalModel.fromJson(professional))
          .toList(),
    );
  }

  factory ClinicModel.fromJsonBySearchClinic(Map json) {
    return ClinicModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      city: json['city'].map<CityModel>((city) => CityModel.fromJson(city)).toList(),
      district: json['district'].map<DistrictModel>((district) => DistrictModel.fromJson(district)).toList(),
      featuredImage: json['featured_image'],
      rating: json['rating'].toDouble(),
    );
  }

  ClinicEntity toEntityBySearchClinic() => ClinicEntity(
        id: id,
        name: name,
        email: email,
        city: city == null ? [] : city!.map<CityEntity>((city) => city.toEntity()).toList(),
        district: district == null ? [] : district!.map<DistrictEntity>((district) => district.toEntity()).toList(),
        featuredImage: featuredImage,
        rating: rating,
      );

  ClinicEntity toEntity() => ClinicEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        description: description,
        address: address,
        district: district == null ? [] : district!.map<DistrictEntity>((district) => district.toEntity()).toList(),
        city: city == null ? [] : city!.map<CityEntity>((city) => city.toEntity()).toList(),
        latitude: latitude,
        longitude: longitude,
        featured: featured,
        featuredImage: featuredImage,
        rating: rating,
        reviews: reviews == null ? [] : reviews!.map<ReviewEntity>((reviews) => reviews.toEntity()).toList(),
        // schedule: schedule == null ? [] : schedule!.map<ScheduleEntity>((schedule) => schedule.toEntity()).toList(),
        schedule: List<List<ScheduleEntity>>.from(
            schedule!.map((x) => List<ScheduleEntity>.from(x.map((x) => x.toEntity())))),
        specialities:
            specialities == null ? [] : specialities!.map<SpecialityEntity>((spec) => spec.toEntity()).toList(),
        insurers: insurers == null ? [] : insurers!.map<InsurerEntity>((insurer) => insurer.toEntity()).toList(),
        professionals:
            professionals == null ? [] : professionals!.map<ProfessionalEntity>((prof) => prof.toEntity()).toList(),
      );
}
