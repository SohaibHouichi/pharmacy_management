import 'package:pharmacy_management/features/sales/data/models/responses/cashier_response.dart';
import 'package:pharmacy_management/features/sales/data/models/responses/sale_item_response.dart';

class SaleResponse {
  final int id;
  final String invoiceNumber;
  final CashierResponse? cashier;
  final num subtotal;
  final num total;
  final String paymentMethod;
  final String status;
  final List<SaleItemResponse> items;
  final DateTime? createdAt;

  const SaleResponse({
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

  factory SaleResponse.fromJson(Map<String, dynamic> json) {
    return SaleResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      invoiceNumber: json['invoice_number'] as String? ?? '',
      cashier: json['cashier'] is Map<String, dynamic>
          ? CashierResponse.fromJson(json['cashier'] as Map<String, dynamic>)
          : null,
      subtotal: (json['subtotal'] as num?) ?? 0,
      total: (json['total'] as num?) ?? 0,
      paymentMethod: json['payment_method'] as String? ?? 'cash',
      status: json['status'] as String? ?? '',
      items: (json['items'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map(SaleItemResponse.fromJson)
              .toList() ??
          const [],
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }
}