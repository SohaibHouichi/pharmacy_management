import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/features/sales/data/models/responses/cashier_response.dart';
import 'package:pharmacy_management/features/sales/data/models/responses/sale_item_response.dart';
import 'package:pharmacy_management/features/sales/data/models/responses/sale_response.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';

extension CashierResponseMapper on CashierResponse {
  CashierEntity toEntity() => CashierEntity(id: id, name: name);
}

extension SaleItemResponseMapper on SaleItemResponse {
  SaleItemEntity toEntity() {
    // Falls back through the two name sources, then a placeholder.
    final resolvedName =
        medicineName ?? medicine?.name ?? 'Deleted medicine';

    return SaleItemEntity(
      id: id,
      medicineId: medicineId,
      name: resolvedName,
      unit: medicine?.unit,
      quantity: quantity,
      unitPrice: unitPrice.toDouble(),
      total: total.toDouble(),
      medicineDeleted: medicineName == null && (medicine?.name == null),
    );
  }
}

extension SaleResponseMapper on SaleResponse {
  SaleEntity toEntity() => SaleEntity(
        id: id,
        invoiceNumber: invoiceNumber,
        cashier: cashier?.toEntity(),
        subtotal: subtotal.toDouble(),
        total: total.toDouble(),
        paymentMethod: paymentMethod,
        status: status,
        items: items.map((item) => item.toEntity()).toList(),
        createdAt: createdAt?.toLocal(),
      );
      
}
extension SalesPageMapper on Paginated<SaleResponse> {
  Paginated<SaleEntity> toEntities() => Paginated<SaleEntity>(
        items: items.map((model) => model.toEntity()).toList(),
        meta: meta,
      );
}
