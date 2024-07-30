import './../../../data/data.dart';
import './../../../domain/domain.dart';

class LocalDeleteCurrentAccount implements DeleteCurrentAccount {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;

  LocalDeleteCurrentAccount(this.deleteSecureCacheStorage);

  @override
  Future<void> call() async {
    try {
      return await deleteSecureCacheStorage.delete('token');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
