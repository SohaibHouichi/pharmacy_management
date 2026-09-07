
import 'package:pharmacy_management/core/domain/expiry_status.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/category_response.dart';

class MedicinesResponse {
  final int id;
  final String name;
  final int categoryId;
  final CategoryResponse? category;
  final num price;
  final int quantity;
  final int minStockLevel;
  final DateTime? expiryDate;
  final ExpiryStatus expiryStatus;
  final bool isLowStock;
  final bool isExpired;
  final bool isExpiringSoon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MedicinesResponse({
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
    this.createdAt,
    this.updatedAt,
  });

  factory MedicinesResponse.fromJson(Map<String, dynamic> json) {
    return MedicinesResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      categoryId: (json['category_id'] as num?)?.toInt() ?? 0,
      category: json['category'] is Map<String, dynamic>
          ? CategoryResponse.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      price: (json['price'] as num?) ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      minStockLevel: (json['min_stock_level'] as num?)?.toInt() ?? 0,
      expiryDate: DateTime.tryParse(json['expiry_date'] as String? ?? ''),
      expiryStatus: ExpiryStatus.fromString(json['expiry_status'] as String?),
      isLowStock: json['is_low_stock'] as bool? ?? false,
      isExpired: json['is_expired'] as bool? ?? false,
      isExpiringSoon: json['is_expiring_soon'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  
}