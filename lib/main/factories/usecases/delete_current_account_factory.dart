import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

DeleteCurrentAccount makeLocalDeleteCurrentAccountFactory() => LocalDeleteCurrentAccount(makeSecureStorageAdapter());
