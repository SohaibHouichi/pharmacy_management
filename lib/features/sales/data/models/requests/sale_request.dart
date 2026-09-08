import 'package:pharmacy_management/features/sales/domain/entity/sale_params.dart';

class SaleRequest {
  final int medicineId;
  final int quantity;

  const SaleRequest({required this.medicineId, required this.quantity});

  Map<String, dynamic> toJson() => {
        'medicine_id': medicineId,
        'quantity': quantity,
      };
}

class CreateSaleRequest {
  final List<SaleRequest> items;

  const CreateSaleRequest({required this.items});

  Map<String, dynamic> toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };
      factory CreateSaleRequest.fromParams(CreateSaleParam param) {
  return CreateSaleRequest(
    items: param.items
        .map((i) => SaleRequest(
              medicineId: i.medicineId,
              quantity: i.quantity,
            ))
        .toList(),
  );
}
}