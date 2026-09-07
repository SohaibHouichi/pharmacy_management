import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_medicine_by_id.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_detail_controller.dart';

class MedicineDetailBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<MedicinesRepository>();

    Get.lazyPut<GetMedicineById>(() => GetMedicineById(repository: repository));

    Get.put<MedicinesDetailController>(
      MedicinesDetailController(
        getMedicineById: Get.find<GetMedicineById>(),

      ),
    );
  }
}
