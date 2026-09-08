import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/network/api_endpoints.dart';
import 'package:pharmacy_management/core/network/api_response.dart';
import 'package:pharmacy_management/core/network/dio_exception_handler.dart';
import 'package:pharmacy_management/core/utils/json_utils.dart';
import 'package:pharmacy_management/features/auth/data/models/requests/auth_request.dart';
import 'package:pharmacy_management/features/auth/data/models/responses/auth_me_response.dart';
import 'package:pharmacy_management/features/auth/data/models/responses/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<AuthResponse>> login(AuthRequest authRequest);
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio api;
  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<ApiResponse<AuthResponse>> login(AuthRequest authRequest) async {
    try {
      final res = await api.post(
        ApiEndpoints.login,
        data: authRequest.toJson(),
      );
      final body = res.data as Map<String, dynamic>;

      if (body['success'] != true || body['data'] == null) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Login failed',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }

      return ApiResponse.fromJson(
        body,
        () => AuthResponse.fromJson(body['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<ApiResponse<UserModel>> getCurrentUser() async {
    try {
      final res = await api.get(ApiEndpoints.currentUser);
      final body = res.data as Map<String, dynamic>;

      return ApiResponse.fromJson(
        body,
        () => UserModel.fromJson(body['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await api.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }
}
