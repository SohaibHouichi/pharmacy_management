import 'package:get/get.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/get_sale_by_id.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_detail_controller.dart';

class SaleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetSaleById>(
      () => GetSaleById(Get.find<SalesRepository>()),
    );
    Get.put<SaleDetailController>(
      SaleDetailController(getSaleById: Get.find<GetSaleById>()),
    );
  }
}