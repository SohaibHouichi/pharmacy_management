class Paginated<T> {
  final List<T> items;
  final PaginationMeta meta;

  Paginated({
    required this.items,
    required this.meta
  });
  bool get isEmpty => items.isEmpty;
  bool get hasNextPage => meta.currentPage < meta.lastPage;

}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int? from;
  final int? to;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.from,
    this.to,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: (json['current_page'] as int?) ?? 1,
      lastPage: (json['last_page'] as int?) ?? 0,
      perPage: (json['per_page'] as int?) ?? 0,
      total: (json['total'] as int?) ?? 0,
      from: json['from'] as int?,
      to: json['to'] as int?,
    );
  }

  bool get isEmpty => total == 0;
  bool get hasNextPage => currentPage < lastPage;
}