import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/core/error/guard.dart';
import 'package:pharmacy_management/features/medicines/data/data_source/medicines_remote_data_source.dart';
import 'package:pharmacy_management/features/medicines/data/models/mappers/medicines_mapper.dart';
import 'package:pharmacy_management/features/medicines/data/models/mappers/medicines_paginated_mapper.dart';
import 'package:pharmacy_management/features/medicines/data/models/requests/medicines_creation_request.dart';
import 'package:pharmacy_management/features/medicines/data/models/requests/medicines_updating_request.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_params.dart';
import 'package:pharmacy_management/features/medicines/domain/repository/medicines_repository.dart';

class MedicinesRepositoryImpl implements MedicinesRepository {
  final MedicinesRemoteDataSource _remote;

  MedicinesRepositoryImpl({required this._remote});

  @override
  Future<Either<Failure, Paginated<MedicineEntity>>> getMedicines({
    String? query,
    int? categoryId,
    int page = 1,
  }) {
    return guard(() async {
      final response = await _remote.getMedicines(
        query: query,
        categoryId: categoryId,
        page: page,
      );
      return response.data.toEntities();
    });
  }

  @override
  Future<Either<Failure, MedicineEntity>> addMedicine(
    CreateMedicineParams params,
  ) {
    return guard(() async {
      final response = await _remote.addMedicines(
        MedicinesCreateRequest.fromParams(params),
      );
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, MedicineEntity>> updateMedicine(
    int id,
    UpdateMedicineParams params,
  ) {
    return guard(() async {
      final response = await _remote.updateMedicines(
        id,
        MedicinesUpdateRequest.fromParams(params),
      );
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteMedicine(int id) {
    return guard(() => _remote.deleteMedicines(id));
  }

  @override
  Future<Either<Failure, MedicineEntity>> getMedicinesById(int id) {
    return guard(() async {
      final response = await _remote.getMedicinesById(id);
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return guard(() async {
      final response = await _remote.getCategories();
      return response.map(((e) => e.toEntity())).toList();
    });
  } // to add a new medicine
}
