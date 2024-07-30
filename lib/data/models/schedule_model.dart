import '../../domain/domain.dart';

class ScheduleModel {
  final int weekday;
  final String start;
  final String end;

  const ScheduleModel({
    required this.weekday,
    required this.start,
    required this.end,
  });

  factory ScheduleModel.fromJson(Map json) =>
      ScheduleModel(weekday: json['weekday'], start: json['start'], end: json['end']);

  ScheduleEntity toEntity() => ScheduleEntity(weekday: weekday, start: start, end: end);
}
