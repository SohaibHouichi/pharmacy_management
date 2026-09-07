import 'package:pharmacy_management/core/network/api_response.dart';

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