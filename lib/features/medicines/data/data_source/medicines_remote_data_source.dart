import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/network/api_endpoints.dart';
import 'package:pharmacy_management/core/network/api_response.dart';
import 'package:pharmacy_management/core/network/dio_exception_handler.dart';
import 'package:pharmacy_management/core/utils/json_utils.dart';
import 'package:pharmacy_management/features/medicines/data/models/requests/medicines_creation_request.dart';
import 'package:pharmacy_management/features/medicines/data/models/requests/medicines_updating_request.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/category_response.dart';
import 'package:pharmacy_management/features/medicines/data/models/responses/medicines_response.dart';

abstract class MedicinesRemoteDataSource {
  Future<ApiResponse<Paginated<MedicinesResponse>>> getMedicines({
    String? query,
    int? categoryId,
    int page = 1,
  });
  Future<ApiResponse<MedicinesResponse>> addMedicines(
    MedicinesCreateRequest req,
  );
  Future<void> deleteMedicines(int id);
  Future<ApiResponse<MedicinesResponse>> updateMedicines(
    int id,
    MedicinesUpdateRequest req,
  );
  Future<MedicinesResponse> getMedicinesById(int id);
  Future<List<CategoryResponse>> getCategories();
}

class MedicinesRemoteDataSourceImpl implements MedicinesRemoteDataSource {
  final Dio api;
  MedicinesRemoteDataSourceImpl(this.api);

  @override
  Future<ApiResponse<MedicinesResponse>> addMedicines(
    MedicinesCreateRequest req,
  ) async {
    try {
      final res = await api.post(ApiEndpoints.medicines, data: req.toJson());
      final body = res.data as Map<String, dynamic>;

      if (body['success'] != true || body['data'] == null) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Creation Failed',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }

      return ApiResponse.fromJson(
        body,
        () => MedicinesResponse.fromJson(body['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> deleteMedicines(int id) async {
    try {
      final res = await api.delete(ApiEndpoints.medicine(id));
      final body = res.data as Map<String, dynamic>;
      // No `data` on delete — success flag is the only signal.
      if (body['success'] != true) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Could not delete medicine',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<ApiResponse<Paginated<MedicinesResponse>>> getMedicines({
    String? query,
    int? categoryId,
    int page = 1,
  }) async {
    try {
      final res = await api.get(
        ApiEndpoints.medicines,
        queryParameters: {
          'page': page,
          if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
          if (categoryId != null) 'category_id': categoryId,
        },
      );
      final body = res.data as Map<String, dynamic>;

      // An empty list is valid here, so only the success flag is checked.
      if (body['success'] != true) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Could not load medicines',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }

      return ApiResponse.fromJson(body, () {
        final items =
            (body['data'] as List?)
                ?.whereType<Map<String, dynamic>>()
                .map(MedicinesResponse.fromJson)
                .toList() ??
            const <MedicinesResponse>[];

        final rawMeta = body['meta'];
        return Paginated<MedicinesResponse>(
          items: items,
          meta: PaginationMeta.fromJson(rawMeta),
        );
      });
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<ApiResponse<MedicinesResponse>> updateMedicines(
    int id,
    MedicinesUpdateRequest req,
  ) async {
    try {
      final res = await api.put(
        '${ApiEndpoints.medicines}/$id',
        data: req.toJson(),
      );
      final body = res.data as Map<String, dynamic>;

      if (body['success'] != true || body['data'] == null) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Could not update medicine',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }

      return ApiResponse.fromJson(
        body,
        () => MedicinesResponse.fromJson(body['data']),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<MedicinesResponse> getMedicinesById(int id) async {
    try {
      final res = await api.get('${ApiEndpoints.medicines}/$id');
      final body = res.data['data'];
      return MedicinesResponse.fromJson(body);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<List<CategoryResponse>> getCategories() async {
    try {
      final res = await api.get(ApiEndpoints.categories);
      final body = res.data as Map<String, dynamic>;

      if (body['success'] != true) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Could not load categories',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }

      return (body['data'] as List?)
              ?.whereType<Map<String, dynamic>>()
              .map(CategoryResponse.fromJson)
              .toList() ??
          const [];
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }
}
