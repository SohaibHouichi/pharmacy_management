import 'package:pharmacy_management/features/dashboard/data/models/responses/today_sales_response.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';

class DashboardResponse {
  final int totalMedicines;
  final int lowStockCount;
  final List<MedicinesResponse> lowStockMedicines;
  final TodaySalesResponse todaySales;

  const DashboardResponse({
    required this.totalMedicines,
    required this.lowStockCount,
    required this.lowStockMedicines,
    required this.todaySales,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      totalMedicines: (json['total_medicines'] as num?)?.toInt() ?? 0,
      lowStockCount: (json['low_stock_count'] as num?)?.toInt() ?? 0,
      lowStockMedicines:
          (json['low_stock_medicines'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map(MedicinesResponse.fromJson)
              .toList() ??
          const [],
      todaySales: json['today_sales'] is Map<String, dynamic>
          ? TodaySalesResponse.fromJson(
              json['today_sales'] as Map<String, dynamic>,
            )
          : const TodaySalesResponse(count: 0, total: 0),
    );
  }
}
