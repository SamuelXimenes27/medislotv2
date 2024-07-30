import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() => LocalSaveCurrentAccount(makeSecureStorageAdapter());
