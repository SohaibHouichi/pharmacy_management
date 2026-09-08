import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/data/models/mappers/medicines_mapper.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

extension MedicinesPageMapper on Paginated<MedicinesResponse> {
  Paginated<MedicineEntity> toEntities() => Paginated<MedicineEntity>(
        items: items.map((model) => model.toEntity()).toList(),
        meta: meta,
      );
}