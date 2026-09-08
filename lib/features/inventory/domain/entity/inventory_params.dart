class UpdateStockParams {
  final int medicineId;

  /// Absolute quantity, not a delta — the server replaces the value.
  final int quantity;

  const UpdateStockParams({
    required this.medicineId,
    required this.quantity,
  });
}