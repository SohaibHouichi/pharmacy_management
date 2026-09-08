import 'package:get/get.dart';
import 'package:pharmacy_management/features/inventory/domain/repository/inventory_repository.dart';
import 'package:pharmacy_management/features/inventory/domain/usecase/update_stock.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_form_controller.dart';

class InventoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateStock>(
      () => UpdateStock(repository: Get.find<InventoryRepository>()),
    );
    Get.put<InventoryFormController>(
      InventoryFormController(updateStock: Get.find<UpdateStock>()),
    );
  }
}
