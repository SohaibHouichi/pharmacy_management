import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_param.dart';

abstract class MedicinesRepository {
  Future<Either<Failure, Paginated<MedicineEntity>>> getMedicines({
    String? query,
    int? categoryId,
    int page = 1,
  });
  Future<Either<Failure, MedicineEntity>> addMedicine(CreateMedicineParams req);
  Future<Either<Failure, void>> deleteMedicine(int id);
  Future<Either<Failure, MedicineEntity>> updateMedicine(
    int id,
    UpdateMedicineParams req,
  );
  Future<Either<Failure, MedicineEntity>> getMedicinesById(int id); // for details 
  Future<Either<Failure, List<CategoryEntity>>> getCategories(); // to add a new medicine
}
