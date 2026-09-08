class TodaySalesResponse {
  final int count;
  final num total;

  const TodaySalesResponse({required this.count, required this.total});

  factory TodaySalesResponse.fromJson(Map<String, dynamic> json) {
    return TodaySalesResponse(
      count: (json['count'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?) ?? 0,
    );
  }
}