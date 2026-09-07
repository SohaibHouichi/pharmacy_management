import 'package:pharmacy_management/core/domain/expiry_status.dart' show ExpiryStatus;
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';

class MedicineEntity {
  final int id;
  final String name;
  final int categoryId;
  final CategoryEntity? category;
  final double price;
  final int quantity;
  final int minStockLevel;
  final DateTime? expiryDate;
  final ExpiryStatus expiryStatus;
  final bool isLowStock;
  final bool isExpired;
  final bool isExpiringSoon;

  const MedicineEntity({
    required this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.price,
    required this.quantity,
    required this.minStockLevel,
    this.expiryDate,
    this.expiryStatus = ExpiryStatus.unknown,
    this.isLowStock = false,
    this.isExpired = false,
    this.isExpiringSoon = false,
  });

  /// How far below the minimum this item sits.
  int get stockDeficit =>
      isLowStock ? (minStockLevel - quantity).clamp(0, minStockLevel) : 0;
}
