import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';

class InventoryUpdatedResponse {
  final MedicinesResponse medicine;
  final int qBefore;
  final int qAfter;
  InventoryUpdatedResponse({
    required this.medicine,
    required this.qBefore,
    required this.qAfter,
  });
  factory InventoryUpdatedResponse.fromJson(Map<String, dynamic> json) {
    return InventoryUpdatedResponse(
      medicine: json['medicine'],
      qBefore: json['quantity_before'],
      qAfter: json['quantity_after'],
    );
  }
}
