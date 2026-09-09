import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_medicine_by_id.dart';

class MedicinesDetailController extends GetxController {
  final GetMedicineById getMedicineById;

  MedicinesDetailController({required this.getMedicineById});

  final Rxn<MedicineEntity> medicine = Rxn<MedicineEntity>();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  late final int medicineId;

@override
void onInit() {
  super.onInit();
  final passed = Get.arguments as int?;
  medicineId = passed ?? 0;
  load();
}

  Future<void> load() async {
    if (medicineId == 0) {
      errorMessage.value = 'Medicine not found.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final result = await getMedicineById(medicineId);

    isLoading.value = false;
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) => medicine.value = data,
    );
  }

 
}