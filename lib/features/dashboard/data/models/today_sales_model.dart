class TodaySalesModel {
  final int count;
  final num total;

  const TodaySalesModel({required this.count, required this.total});

  factory TodaySalesModel.fromJson(Map<String, dynamic> json) {
    return TodaySalesModel(
      count: (json['count'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?) ?? 0,
    );
  }
}