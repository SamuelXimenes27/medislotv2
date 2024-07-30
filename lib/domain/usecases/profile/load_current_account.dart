import 'package:medislot/domain/domain.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity> load();
}
