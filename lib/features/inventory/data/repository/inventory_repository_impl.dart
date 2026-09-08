import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/data/data_source/inventory_remote_data_source.dart';
import 'package:pharmacy_management/features/inventory/data/models/mappers/inventory_mapper.dart';
import 'package:pharmacy_management/features/inventory/data/models/requests/inventory_request.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_params.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_updated_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/repository/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSource _remote;

  InventoryRepositoryImpl({required this._remote});

  @override
  Future<Either<Failure, InventoryAlertsEntity>> getInventory() {
    return guard(() async {
      final response = await _remote.getInventory();
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, InventoryUpdatedEntity>> updateStock(
    UpdateStockParams res,
  ) {
    return guard(() async {
      final response = await _remote.updateInventory(
        InventoryRequest.fromParams(res),
      );
      return response.data.toEntity();
    });
  }
}
