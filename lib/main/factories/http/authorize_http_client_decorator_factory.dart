import 'package:medislot/data/data.dart';
import 'package:medislot/main/decorators/decorators.dart';
import 'package:medislot/main/factories/factories.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
      getSecureCacheStorage: makeSecureStorageAdapter(),
      deleteSecureCacheStorage: makeSecureStorageAdapter(),
      decorate: makeHttpAdapter(),
    );
