import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/add_medicine.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_categories.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/update_medicine.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicine_form_controller.dart';

class MedicineFormBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<MedicinesRepository>();

    Get.lazyPut<AddMedicine>(() => AddMedicine(repository: repository));
    Get.lazyPut<UpdateMedicine>(() => UpdateMedicine(repository: repository));
    Get.lazyPut<GetCategories>(() => GetCategories(repository: repository));

    Get.put<MedicineFormController>(
      MedicineFormController(
        addMedicine: Get.find<AddMedicine>(),
        updateMedicine: Get.find<UpdateMedicine>(),
        getCategories: Get.find<GetCategories>(),
      ),
    );
  }
}
