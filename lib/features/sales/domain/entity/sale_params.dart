class SaleParam {
  final int medicineId;
  final int quantity;

  const SaleParam({required this.medicineId, required this.quantity});
}

class CreateSaleParam {
  final List<SaleParam> items;

  const CreateSaleParam({required this.items});
}
