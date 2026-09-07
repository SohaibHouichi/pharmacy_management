import 'package:pharmacy_management/features/sales/data/models/responses/sales_medicine_items_response.dart';

class SaleItemResponse {
  final int id;
  final int medicineId;
  final String? medicineName;
  final int quantity;
  final num unitPrice;
  final num total;
  final SaleItemMedicineResponse? medicine;

  const SaleItemResponse({
    required this.id,
    required this.medicineId,
    this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    this.medicine,
  });

  factory SaleItemResponse.fromJson(Map<String, dynamic> json) {
    return SaleItemResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      medicineId: (json['medicine_id'] as num?)?.toInt() ?? 0,
      medicineName: json['medicine_name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unit_price'] as num?) ?? 0,
      total: (json['total'] as num?) ?? 0,
      medicine: json['medicine'] is Map<String, dynamic>
          ? SaleItemMedicineResponse.fromJson(
              json['medicine'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}