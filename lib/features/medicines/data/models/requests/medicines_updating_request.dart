import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_params.dart';

class MedicinesUpdateRequest {
  final String name;
  final int categoryId;
  final double price;
  final String expiryDate;
  MedicinesUpdateRequest({
    required this.name,
    required this.categoryId,
    required this.price,
    required this.expiryDate,
  });
  Map<String, dynamic> toJson() => {
    'name': name,
    'category_id': categoryId,
    'price': price,
    'expiry_date': expiryDate,
  };
  factory MedicinesUpdateRequest.fromParams(UpdateMedicineParams p) {
    return MedicinesUpdateRequest(
      name: p.name.trim(),
      categoryId: p.categoryId,
      price: p.price,
      expiryDate: JsonUtils.formatDate(p.expiryDate),
    );
  }
}
