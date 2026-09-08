import 'package:pharmacy_management/features/dashboard/data/models/responses/dashboard_response.dart';
import 'package:pharmacy_management/features/dashboard/data/models/responses/today_sales_response.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/medicines/data/models/mappers/medicines_mapper.dart';


extension TodaySalesResponseMapper on TodaySalesResponse {
  TodaySalesEntity toEntity() => TodaySalesEntity(
        count: count,
        total: total.toDouble(),
      );
}

extension DashboardResponseMapper on DashboardResponse {
  DashboardEntity toEntity() => DashboardEntity(
        totalMedicines: totalMedicines,
        lowStockCount: lowStockCount,
        lowStockMedicines: lowStockMedicines.toEntities(),
        todaySales: todaySales.toEntity(),
      );
}