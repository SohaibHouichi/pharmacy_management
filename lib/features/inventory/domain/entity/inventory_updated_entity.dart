import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class InventoryUpdatedEntity {
  final MedicineEntity? medicine;
  final int quantityBefore;
  final int quantityAfter;

  const InventoryUpdatedEntity({
    this.medicine,
    required this.quantityBefore,
    required this.quantityAfter,
  });

  /// Positive when stock was added, negative when it was reduced.
  int get delta => quantityAfter - quantityBefore;

  bool get increased => delta > 0;
  bool get unchanged => delta == 0;

  /// e.g. "+15" or "-8", for the confirmation message.
  String get deltaLabel => delta > 0 ? '+$delta' : '$delta';
}