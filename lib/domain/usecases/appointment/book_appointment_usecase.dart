abstract class BookAppoimentUsecase {
  Future<void> call(BookAppointmentParam param);
}

class BookAppointmentParam {
  final int specialtyId;
  final int professionalId;
  final bool video;
  final DateTime date;
  final String name;
  final double value;

  BookAppointmentParam({
    required this.specialtyId,
    required this.professionalId,
    required this.video,
    required this.date,
    required this.name,
    required this.value,
  });
}
