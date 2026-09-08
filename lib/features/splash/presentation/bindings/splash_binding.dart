import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import 'package:pharmacy_management/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:pharmacy_management/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:pharmacy_management/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pharmacy_management/features/auth/auth.dart';
import 'package:pharmacy_management/features/splash/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<Dio>()),
      fenix: true,
    );
    Get.lazyPut<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: Get.find<AuthRemoteDataSource>(),
        local: Get.find<AuthLocalDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetCurrentUser>(
      () => GetCurrentUser(repository: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.put<SplashController>(
      SplashController(
        getCurrentUserUseCase: Get.find<GetCurrentUser>(),
        session: Get.find<SessionService>(),
      ),
    );
  }
}
