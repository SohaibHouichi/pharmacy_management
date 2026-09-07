import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class GetMedicines {
  final MedicinesRepository _repository;
  GetMedicines({required this._repository});
  Future<Either<Failure, Paginated<MedicineEntity>>> call({
    String? query,
    int? categoryId,
    int page = 1,
  }) {
    return _repository.getMedicines(
      query: query,
      categoryId: categoryId,
      page: page,
    );
  }
}
