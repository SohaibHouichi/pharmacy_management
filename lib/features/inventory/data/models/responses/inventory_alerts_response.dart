import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';

class InventoryAlertsResponse {
  final List<MedicinesResponse> lowStock;
  final List<MedicinesResponse> expiringSoon;
  final List<MedicinesResponse> expired;

  const InventoryAlertsResponse({
    required this.lowStock,
    required this.expiringSoon,
    required this.expired,
  });

  factory InventoryAlertsResponse.fromJson(Map<String, dynamic> json) {
    return InventoryAlertsResponse(
      lowStock: _parseList(json['low_stock']),
      expiringSoon: _parseList(json['expiring_soon']),
      expired: _parseList(json['expired']),
    );
  }

  static List<MedicinesResponse> _parseList(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(MedicinesResponse.fromJson)
        .toList();
  }
}