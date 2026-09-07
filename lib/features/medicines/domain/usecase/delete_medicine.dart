import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class DeleteMedicine {
  final MedicinesRepository _repository;
  DeleteMedicine({required this._repository});

  Future<Either<Failure, void>> call(int id) async {
    return await _repository.deleteMedicine(id);
  }
}
