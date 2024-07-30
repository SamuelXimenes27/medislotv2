import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medislot/infra/cache/cache.dart';

SecureStorageAdapter makeSecureStorageAdapter() => SecureStorageAdapter(secureStorage: const FlutterSecureStorage());
