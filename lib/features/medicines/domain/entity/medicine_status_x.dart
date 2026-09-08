import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart' show MedicineEntity;


extension MedicineStatusX on MedicineEntity {
  /// The expiry badge, or null when the medicine is simply valid.
  StatusStyle? get expiryBadge {
    if (isExpired) return StatusConfig.expired;
    if (isExpiringSoon) return StatusConfig.expiringSoon;
    return null;
  }

  /// The stock badge, or null when stock is healthy.
  StatusStyle? get stockBadge {
    if (quantity == 0) return StatusConfig.outOfStock;
    if (isLowStock) return StatusConfig.lowStock;
    return null;
  }

  /// Every badge worth showing, in priority order.
  List<StatusStyle> get badges =>
      [expiryBadge, stockBadge].whereType<StatusStyle>().toList();

  /// Full expiry style including "valid", for detail views.
  StatusStyle get expiryStyle => StatusConfig.forExpiry(expiryStatus);
}