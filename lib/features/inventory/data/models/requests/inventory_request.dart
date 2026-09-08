import 'package:pharmacy_management/features/inventory/domain/entity/inventory_params.dart';

class InventoryRequest {
  final int medicineId;
  final int quantity;
  InventoryRequest({required this.medicineId, required this.quantity});

  Map<String, dynamic> toJson() => {
    "medicine_id": medicineId,
    "quantity": quantity,
  };
   factory InventoryRequest.fromParams(UpdateStockParams p) {
    return InventoryRequest(
      medicineId: p.medicineId,
      quantity: p.quantity,
    );
  }
}
