import 'package:medislot/domain/entities/history_entity.dart';

abstract class GetHistoryUsecase {
  Future<List<HistoryEntity>> call();
}
