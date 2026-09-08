import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class InventoryAlertsEntity {
  final List<MedicineEntity> lowStock;
  final List<MedicineEntity> expiringSoon;
  final List<MedicineEntity> expired;

  const InventoryAlertsEntity({
    required this.lowStock,
    required this.expiringSoon,
    required this.expired,
  });

  bool get isEmpty =>
      lowStock.isEmpty && expiringSoon.isEmpty && expired.isEmpty;

  int get totalAlerts =>
      lowStock.length + expiringSoon.length + expired.length;
}