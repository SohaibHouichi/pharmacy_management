import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_params.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_updated_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/repository/inventory_repository.dart';

class UpdateStock {
  final InventoryRepository _repository;
  UpdateStock({required this._repository});
  Future<Either<Failure, InventoryUpdatedEntity>> call(
    UpdateStockParams req,
  ) async => await _repository.updateStock(req);
}
