import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> read({required String key}) async {
    final result = await _secureStorage.read(key: key);
    return result;
  }

  Future<void> write({
    required String key,
    required String value,
  }) async {
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }
}
