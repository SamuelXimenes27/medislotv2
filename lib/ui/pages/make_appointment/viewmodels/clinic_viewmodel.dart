import '../../../../data/models/professional_model.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../data/models/speciality_model.dart';

class MakeAppointmentClinicViewmodel {
  final String id;
  final String name;
  final List<ProfessionalModel> professionals;
  final List<SpecialityModel> specialties;
  final List<List<ScheduleModel>>? schedule;
  final double value;

  MakeAppointmentClinicViewmodel({
    required this.id,
    required this.name,
    required this.professionals,
    required this.specialties,
    required this.schedule,
    required this.value,
  });

  factory MakeAppointmentClinicViewmodel.fromJson(Map json) {
    return MakeAppointmentClinicViewmodel(
      id: json['id'],
      name: json['name'],
      professionals: json['professionals']
          .map<ProfessionalModel>((professional) => ProfessionalModel.fromJson(professional))
          .toList(),
      specialties:
          json['specialties'].map<SpecialityModel>((speciality) => SpecialityModel.fromJson(speciality)).toList(),
      schedule: List<List<ScheduleModel>>.from(
          json["schedule"].map((x) => List<ScheduleModel>.from(x.map((x) => ScheduleModel.fromJson(x))))),
      value: json['value'],
    );
  }
}
