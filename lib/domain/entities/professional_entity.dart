import 'package:equatable/equatable.dart';
import 'package:medislot/domain/entities/entities.dart';

class ProfessionalEntity extends Equatable {
  final int id;
  final int? clinicId;
  final String name;
  final String? photo;
  final DateTime? nextAvailableSlot;
  final List<SpecialityEntity>? specialties;
  final String? title;
  final String? titledName;
  final ClinicEntity? clinic;

  const ProfessionalEntity({
    required this.id,
    required this.clinicId,
    required this.name,
    this.photo,
    this.nextAvailableSlot,
    this.specialties,
    this.title,
    this.titledName,
    this.clinic,
  });

  @override
  List<Object?> get props => [id, name, photo, nextAvailableSlot, specialties];
}
