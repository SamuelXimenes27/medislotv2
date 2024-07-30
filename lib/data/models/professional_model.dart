import '../../data/data.dart';
import '../../domain/domain.dart';

class ProfessionalModel {
  final int id;
  final String name;
  final String photo;
  final int? clinicId;
  final DateTime? nextAvailableSlot;
  final List<SpecialityModel>? specialties;
  final String? title;
  final String? titledName;
  final ClinicModel? clinic;

  const ProfessionalModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.clinicId,
    this.nextAvailableSlot,
    this.specialties,
    this.title,
    this.titledName,
    this.clinic,
  });

  factory ProfessionalModel.fromJson(Map json) => ProfessionalModel(
        clinicId: json['clinic_id'],
        id: json['id'],
        name: json['name'],
        photo: json['photo'],
        nextAvailableSlot: json['nextAvailableSlot'] == null ? null : DateTime.parse(json['nextAvailableSlot']),
        specialties:
            json['specialties'].map<SpecialityModel>((speciality) => SpecialityModel.fromJson(speciality)).toList(),
      );

  factory ProfessionalModel.fromJsonForHistory(Map json) => ProfessionalModel(
        id: json['id'],
        clinicId: json['clinic_id'],
        title: json['title'],
        name: json['name'],
        titledName: json['titled_name'],
        clinic: ClinicModel.fromJson(json),
        photo: json['photo'],
        nextAvailableSlot: json['nextAvailableSlot'] == null ? null : DateTime.parse(json['nextAvailableSlot']),
        specialties:
            json['specialties'].map<SpecialityModel>((speciality) => SpecialityModel.fromJson(speciality)).toList(),
      );

  ProfessionalEntity toEntity() => ProfessionalEntity(
        id: id,
        clinicId: clinicId,
        clinic: clinic?.toEntity(),
        title: title,
        titledName: titledName,
        name: name,
        photo: photo,
        nextAvailableSlot: nextAvailableSlot,
        specialties: specialties == null ? [] : specialties!.map((e) => e.toEntity()).toList(),
      );
}
