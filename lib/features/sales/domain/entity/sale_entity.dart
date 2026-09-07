class CashierEntity {
  final int id;
  final String name;

  const CashierEntity({required this.id, required this.name});
}

class SaleItemEntity {
  final int id;
  final int medicineId;
  final String name;
  final String? unit;
  final int quantity;
  final double unitPrice;
  final double total;
  final bool medicineDeleted;

  const SaleItemEntity({
    required this.id,
    required this.medicineId,
    required this.name,
    this.unit,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    this.medicineDeleted = false,
  });
}

class SaleEntity {
  final int id;
  final String invoiceNumber;
  final CashierEntity? cashier;
  final double subtotal;
  final double total;
  final String paymentMethod;
  final String status;
  final List<SaleItemEntity> items;
  final DateTime? createdAt;

  const SaleEntity({
    required this.id,
    required this.invoiceNumber,
    this.cashier,
    required this.subtotal,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.items,
    this.createdAt,
  });

  int get itemCount => items.length;
  int get totalUnits => items.fold(0, (sum, item) => sum + item.quantity);
  bool get isCompleted => status == 'completed';
}