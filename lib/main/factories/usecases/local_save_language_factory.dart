import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

SaveLanguageUsecase makeSaveLanguageUsecaseFactory() => LocalSaveLanguage(makeSecureStorageAdapter());
