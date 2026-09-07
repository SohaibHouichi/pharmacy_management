import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_medicines.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/create_sale.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_form_controller.dart';

class SaleFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSale>(() => CreateSale(Get.find<SalesRepository>()));
    // Reuses the medicines feature to search for line items.
    Get.lazyPut<GetMedicines>(
      () => GetMedicines(repository: Get.find<MedicinesRepository>()),
      fenix: true,
    );
    Get.put<SaleFormController>(
      SaleFormController(
        createSale: Get.find<CreateSale>(),
        getMedicines: Get.find<GetMedicines>(),
      ),
    );
  }
}
