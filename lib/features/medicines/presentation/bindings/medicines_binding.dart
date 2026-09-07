import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/data/data_source/medicines_remote_data_source.dart';
import 'package:pharmacy_management/features/medicines/data/repository/medicines_repository_impl.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/delete_medicine.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_medicines.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';

class MedicinesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicinesRemoteDataSource>(
      () => MedicinesRemoteDataSourceImpl(Get.find<Dio>()),
      fenix: true,
    );
    // fenix keeps the category cache alive across form visits.
    Get.lazyPut<MedicinesRepository>(
      () => MedicinesRepositoryImpl(
        remote: Get.find<MedicinesRemoteDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetMedicines>(
      () => GetMedicines(repository: Get.find<MedicinesRepository>()),
      fenix: true,
    );
    Get.lazyPut<DeleteMedicine>(
      () => DeleteMedicine(repository: Get.find<MedicinesRepository>()),
      fenix: true,
    );
    Get.put<MedicinesController>(
      MedicinesController(
        getMedicines: Get.find<GetMedicines>(),
        deleteMedicine: Get.find<DeleteMedicine>(),
      ),
    );
  }
}
