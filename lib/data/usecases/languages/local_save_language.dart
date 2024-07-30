import 'package:medislot/domain/usecases/language/save_language_usecase.dart';

import '../../../domain/helpers/domain_error.dart';
import '../../cache/save_secure_cache_storage.dart';

class LocalSaveLanguage implements SaveLanguageUsecase {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveLanguage(this.saveSecureCacheStorage);

  @override
  Future<void> call(String locale) async {
    try {
      await saveSecureCacheStorage.save(key: 'locale', value: locale);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
