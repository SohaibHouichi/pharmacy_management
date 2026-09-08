import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_params.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_updated_entity.dart';

abstract class InventoryRepository {
  Future<Either<Failure,InventoryAlertsEntity>> getInventory();
  Future<Either<Failure,InventoryUpdatedEntity>> updateStock(UpdateStockParams req);
}