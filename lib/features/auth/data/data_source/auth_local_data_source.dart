import 'package:pharmacy_management/core/core.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthToken(String token);
  Future<String?> getCachedAuthToken();
  Future<void> clearCachedAuthToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheAuthToken(String token) async {
    try {
      await StorageService.setSecuredString(StorageKeys.token, token);
    } catch (e) {
      throw CacheException(message: e.toString() + AppConstants.cacheExceptionMessage);
    }
  }

  @override
  Future<String?> getCachedAuthToken() async {
    try {
      final token = await StorageService.getSecuredString(StorageKeys.token);
      return token;
    } catch (e) {
      throw CacheException(message: e.toString() + AppConstants.cacheExceptionMessage);
    }
  }

  @override
  Future<void> clearCachedAuthToken() async {
    try {
      await StorageService.clearSecuredString();
    } catch (e) {
      throw CacheException(message: e.toString() + AppConstants.cacheExceptionMessage);
    }
  }
}
