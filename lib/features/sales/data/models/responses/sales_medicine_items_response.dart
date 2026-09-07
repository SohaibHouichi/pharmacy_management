/// The medicine snapshot embedded in a sale item.
/// All fields are nullable — the medicine may have been deleted since.
class SaleItemMedicineResponse {
  final int? id;
  final String? name;
  final String? unit;

  const SaleItemMedicineResponse({this.id, this.name, this.unit});

  factory SaleItemMedicineResponse.fromJson(Map<String, dynamic> json) {
    return SaleItemMedicineResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      unit: json['unit'] as String?,
    );
  }

  bool get isDeleted => id == null;
}