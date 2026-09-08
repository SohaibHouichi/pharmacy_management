import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';

class InventoryUpdatedResponse {
  final MedicinesResponse? medicine;
  final int qBefore;
  final int qAfter;
  InventoryUpdatedResponse({
    this.medicine,
    required this.qBefore,
    required this.qAfter,
  });
  factory InventoryUpdatedResponse.fromJson(Map<String, dynamic> json) {
    return InventoryUpdatedResponse(
      medicine: json['medicine'] is Map<String, dynamic>
          ? MedicinesResponse.fromJson(json['medicine'] as Map<String, dynamic>)
          : null,
      qBefore: json['quantity_before'],
      qAfter: json['quantity_after'],
    );
  }
}
