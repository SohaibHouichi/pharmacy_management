import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class TodaySalesEntity {
  final int count;
  final double total;

  const TodaySalesEntity({required this.count, required this.total});

  bool get isEmpty => count == 0;
}

class DashboardEntity {
  final int totalMedicines;
  final int lowStockCount;
  final List<MedicineEntity> lowStockMedicines;
  final TodaySalesEntity todaySales;

  const DashboardEntity({
    required this.totalMedicines,
    required this.lowStockCount,
    required this.lowStockMedicines,
    required this.todaySales,
  });

  bool get hasLowStock => lowStockCount > 0;

  /// Subset of low-stock items that are also near expiry.
  List<MedicineEntity> get urgentMedicines =>
      lowStockMedicines.where((m) => m.isExpiringSoon || m.isExpired).toList();
}