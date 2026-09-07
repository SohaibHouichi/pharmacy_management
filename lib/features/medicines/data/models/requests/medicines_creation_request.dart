import 'package:pharmacy_management/core/utils/json_utils.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_param.dart';

class MedicinesCreateRequest {
  final String name;
  final int categoryId;
  final double price;
  final int quantity;
  final String expiryDate;
  MedicinesCreateRequest({
    required this.name,
    required this.categoryId,
    required this.price,
    required this.quantity,
    required this.expiryDate,
  });
  Map<String, dynamic> toJson() => {
    'name': name,
    'category_id': categoryId,
    'price': price,
    'quantity': quantity,
    'expiry_date': expiryDate,
  };
  factory MedicinesCreateRequest.fromParams(CreateMedicineParams p) {
    return MedicinesCreateRequest(
      name: p.name.trim(),
      categoryId: p.categoryId,
      price: p.price,
      quantity: p.quantity,
      expiryDate: JsonUtils.formatDate(p.expiryDate),
    );
  }
}
