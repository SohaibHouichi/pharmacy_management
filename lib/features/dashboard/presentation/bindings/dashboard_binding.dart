import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import 'package:pharmacy_management/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:pharmacy_management/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:pharmacy_management/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:pharmacy_management/features/dashboard/domain/usecase/get_dashborad.dart';
import 'package:pharmacy_management/features/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(api: Get.find<Dio>()),
    );
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepositoryImpl(remote: Get.find<DashboardRemoteDataSource>()),
    );
    Get.lazyPut<GetDashboardUsecase>(
      () => GetDashboardUsecase(dashboardRepository:  Get.find<DashboardRepository>()),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        getDashboardUseCase: Get.find<GetDashboardUsecase>(),
        session: Get.find<SessionService>(),
      ),
    );
  }
}