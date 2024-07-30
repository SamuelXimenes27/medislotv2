import '../../../data/data.dart';
import '../../../domain/domain.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final GetSecureCacheStorage getSecureCacheStorage;

  LocalLoadCurrentAccount(this.getSecureCacheStorage);

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await getSecureCacheStorage.get('token');
      if (token == null) throw Error();
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
