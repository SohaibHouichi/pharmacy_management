import 'package:pharmacy_management/core/utils/json_utils.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final T data;
  final Map<String, List<String>>? errors;
  final PaginationMeta? meta;

  const ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function() dataParser,
  ) {
    return ApiResponse<T>(
      success: (json['success'] as bool?) ?? false,
      message: (json['message'] as String?) ?? '',
      data: dataParser(),
      errors: JsonUtils.parseErrors(json['errors']),
      meta: json['meta'] != null
          ? PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
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