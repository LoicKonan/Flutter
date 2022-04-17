import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUserName = 'username';

  static Future setUserName(String username) async =>
      await _storage.write(key: _keyUserName, value: username);

  static Future<String?> getUserName() async =>
      await _storage.read(key: _keyUserName);
}
