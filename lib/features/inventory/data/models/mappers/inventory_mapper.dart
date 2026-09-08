import 'package:pharmacy_management/features/inventory/data/models/responses/inventory_alerts_response.dart';
import 'package:pharmacy_management/features/inventory/data/models/responses/inventory_updated_response.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_updated_entity.dart';
import 'package:pharmacy_management/features/medicines/data/models/mappers/medicines_mapper.dart';

extension InventoryAlertsResponseMapper on InventoryAlertsResponse {
  InventoryAlertsEntity toEntity() => InventoryAlertsEntity(
        lowStock: lowStock.map((m) => m.toEntity()).toList(),
        expiringSoon: expiringSoon.map((m) => m.toEntity()).toList(),
        expired: expired.map((m) => m.toEntity()).toList(),
      );
}

extension InventoryUpdatedResponseMapper on InventoryUpdatedResponse {
  InventoryUpdatedEntity toEntity() => InventoryUpdatedEntity(
        medicine: medicine!.toEntity(),
        quantityBefore: qBefore,
        quantityAfter: qAfter,
      );
}