import 'package:medislot/domain/entities/entities.dart';

class ClinicEntity {
  final int id;
  final String name;
  final String? email;
  final String? description;
  final String? address;
  final String? phone;
  final List<DistrictEntity>? district;
  final List<CityEntity>? city;
  final double? latitude;
  final double? longitude;
  final int? featured;
  final String? featuredImage;
  final double? rating;
  final List<ReviewEntity>? reviews;
  final List<List<ScheduleEntity>>? schedule;
  final List<SpecialityEntity>? specialities;
  final List<InsurerEntity>? insurers;
  final List<ProfessionalEntity>? professionals;

  ClinicEntity({
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
}
