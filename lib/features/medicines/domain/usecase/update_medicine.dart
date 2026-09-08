import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_params.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class UpdateMedicine {
  final MedicinesRepository _repository;
  UpdateMedicine({required this._repository});
  Future<Either<Failure, MedicineEntity>> call(
    int id,
    UpdateMedicineParams req,
  ) async {
    return await _repository.updateMedicine(id, req);
  }
}
