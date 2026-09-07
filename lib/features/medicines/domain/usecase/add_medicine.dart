import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_param.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class AddMedicine {
  final MedicinesRepository _repository;
  AddMedicine({required this._repository});

  Future<Either<Failure, MedicineEntity>> call(CreateMedicineParams req) async {
    return await _repository.addMedicine(req);
  }
}
