//import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  StorageService._();

  static Future<void> setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
   // debugPrint('Setting secured string for key: $key');
    await flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
   // debugPrint('Getting secured string for key: $key');
    return await flutterSecureStorage.read(key: key);
  }

  static Future<void> clearSecuredString() async {
    const flutterSecureStorage = FlutterSecureStorage();
   // debugPrint('Clearing all secured strings');
    await flutterSecureStorage.deleteAll();
  }
}
