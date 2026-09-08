import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/inventory/data/data_source/inventory_remote_data_source.dart';
import 'package:pharmacy_management/features/inventory/data/repository/inventory_repository_impl.dart';
import 'package:pharmacy_management/features/inventory/domain/repository/inventory_repository.dart';
import 'package:pharmacy_management/features/inventory/domain/usecase/get_inventory_alerts.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryRemoteDataSource>(
      () => InventoryRemoteDataSourceImpl(api: Get.find<Dio>()),
      fenix: true,
    );
    Get.lazyPut<InventoryRepository>(
      () => InventoryRepositoryImpl(
        remote: Get.find<InventoryRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetInventoryAlerts>(
      () => GetInventoryAlerts(repository: Get.find<InventoryRepository>()),
      fenix: true,
    );
    Get.put<InventoryController>(
      InventoryController(getInventoryAlerts: Get.find<GetInventoryAlerts>()),
    );
  }
}
