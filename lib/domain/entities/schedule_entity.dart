import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final int weekday;
  final String start;
  final String end;

  const ScheduleEntity({required this.weekday, required this.start, required this.end});

  @override
  List<Object?> get props => [weekday, start, end];
}
