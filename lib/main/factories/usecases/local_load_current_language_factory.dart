import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

LoadCurrentLanguageUsecase makeLoadCurrentLanguageUsecaseFactory() =>
    LocalLoadCurrentLanguage(makeSecureStorageAdapter());
