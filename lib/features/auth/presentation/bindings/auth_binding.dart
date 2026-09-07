import 'package:get/get.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/data_source/auth_local_data_source.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecase/login.dart';
import '../../domain/usecase/logout.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(
      () =>
          AuthRemoteDataSourceImpl(Get.find()), // Dio comes from InitialBinding
    );
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: Get.find<AuthRemoteDataSource>(),
        local: Get.find<AuthLocalDataSource>(),
      ),
    );
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<LogoutUseCase>(() => LogoutUseCase(Get.find<AuthRepository>()));

    Get.lazyPut<AuthController>(
  () => AuthController(
    loginUseCase: Get.find<LoginUseCase>(),
    logoutUseCase: Get.find<LogoutUseCase>(),
    session: Get.find<SessionService>(),
  ),
);
  }
}
