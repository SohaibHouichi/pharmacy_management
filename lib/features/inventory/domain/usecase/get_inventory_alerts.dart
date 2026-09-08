import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/repository/inventory_repository.dart';

class GetInventoryAlerts {
  final InventoryRepository _repository;
  GetInventoryAlerts({required this._repository});

  Future<Either<Failure, InventoryAlertsEntity>> call() async =>
      await _repository.getInventory();
}
