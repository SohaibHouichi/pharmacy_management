import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/utils/json_utils.dart';

class DioExceptionHandler {
  const DioExceptionHandler._();

  static Exception handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'Connection timed out. Please try again.',
        );

      case DioExceptionType.cancel:
        return const NetworkException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Invalid server certificate.');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const NetworkException(
          message: AppConstants.networkExceptionMessage,
        );

      case DioExceptionType.badResponse:
        return _fromResponse(e.response);
      case DioExceptionType.transformTimeout:
        return const NetworkException(
          message: 'Response transformation timed out. Please try again.',
        );
    }
  }

  static Exception _fromResponse(Response? response) {
    final status = response?.statusCode;
    final body = response?.data is Map<String, dynamic>
        ? response!.data as Map<String, dynamic>
        : const <String, dynamic>{};

    final message = (body['message'] as String?)?.trim();

    switch (status) {
      case 401:
        return UnauthorizedException(
          message: message ?? 'Session expired. Please log in again.',
        );
      case 403:
        return ForbiddenException(
          message: message ?? 'Your account is inactive.',
        );
      case 404:
        return NotFoundException(
          message: message ?? 'Resource not found.',
        );
      case 422:
        return ValidationException(
          message: message ?? 'Validation failed',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      default:
        if (status != null && status >= 500) {
          return ServerException(
            message: message ?? 'Server error. Please try again later.',
          );
        }
        return NetworkException(
          message: message ?? AppConstants.networkExceptionMessage,
        );
    }
  }

}