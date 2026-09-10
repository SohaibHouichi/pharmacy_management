import 'package:pharmacy_management/core/domain/paginated.dart';
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
