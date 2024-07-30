import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() => LocalLoadCurrentAccount(makeSecureStorageAdapter());
