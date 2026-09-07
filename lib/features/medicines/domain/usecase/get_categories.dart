import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class GetCategories {
  final MedicinesRepository _repository;
  GetCategories({required this._repository});
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await _repository.getCategories();
  }
}
