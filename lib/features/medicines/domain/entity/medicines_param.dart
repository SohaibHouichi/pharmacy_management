class CreateMedicineParams {
  final String name;
  final int categoryId;
  final double price;
  final int quantity;
  final DateTime expiryDate;

  const CreateMedicineParams({
    required this.name,
    required this.categoryId,
    required this.price,
    required this.quantity,
    required this.expiryDate,
  });
}

class UpdateMedicineParams {
  final String name;
  final int categoryId;
  final double price;
  final DateTime expiryDate;
  // No quantity — stock changes go through POST /inventory/stock.

  const UpdateMedicineParams({
    required this.name,
    required this.categoryId,
    required this.price,
    required this.expiryDate,
  });
}