import 'package:get/get.dart';
import 'package:pharmacy_management/core/storage/storage_keys.dart';
import 'package:pharmacy_management/core/storage/storage_service.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';

/// Holds the authenticated user for the lifetime of the app.
/// Registered permanently, so it survives every route change.
class SessionService extends GetxService {
  final Rxn<UserEntity> user = Rxn<UserEntity>();

  bool get isLoggedIn => user.value != null;

  Future<String?> readToken() async {
    try {
      return await StorageService.getSecuredString(StorageKeys.token);
    } catch (_) {
      return null;
    }
  }

  Future<bool> hasToken() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }

  void setUser(UserEntity value) => user.value = value;

  Future<void> clear() async {
    user.value = null;
    try {
      await StorageService.clearSecuredString();
    } catch (_) {
      // Nothing to do if secure storage is already empty.
    }
  }
}