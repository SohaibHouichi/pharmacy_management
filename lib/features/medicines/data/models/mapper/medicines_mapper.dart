import 'package:pharmacy_management/features/medicines/data/models/responses/category_response.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

extension CategoryResponseMapper on CategoryResponse {
  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        nameAr: nameAr,
      );
}

extension MedicineModelMapper on MedicinesResponse {
  MedicineEntity toEntity() => MedicineEntity(
        id: id,
        name: name,
        categoryId: categoryId,
        category: category?.toEntity(),
        price: price.toDouble(),
        quantity: quantity,
        minStockLevel: minStockLevel,
        expiryDate: expiryDate?.toLocal(),
        expiryStatus: expiryStatus,
        isLowStock: isLowStock,
        isExpired: isExpired,
        isExpiringSoon: isExpiringSoon,
      );
}

extension MedicineListMapper on List<MedicinesResponse> {
  List<MedicineEntity> toEntities() =>
      map((model) => model.toEntity()).toList();
}