class CashierResponse {
  final int id;
  final String name;

  const CashierResponse({required this.id, required this.name});

  factory CashierResponse.fromJson(Map<String, dynamic> json) {
    return CashierResponse(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}