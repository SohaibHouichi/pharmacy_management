import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class GetMedicineById {
  final MedicinesRepository _repository;
  GetMedicineById({required this._repository});
  Future<Either<Failure, MedicineEntity>> call(int id) async {
    return await _repository.getMedicinesById(id);
  }
}
