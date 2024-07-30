import '../../../data/data.dart';
import '../../../domain/domain.dart';

class LocalLoadCurrentLanguage implements LoadCurrentLanguageUsecase {
  final GetSecureCacheStorage getSecureCacheStorage;

  LocalLoadCurrentLanguage(this.getSecureCacheStorage);

  @override
  Future<String> call() async {
    try {
      final locale = await getSecureCacheStorage.get('locale');
      if (locale == null) return 'pt_br';
      return locale;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
