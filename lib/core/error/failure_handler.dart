import 'package:pharmacy_management/core/core.dart';
class FailureHandler {
  const FailureHandler._();

  static Failure fromException(Object exception) {
    if (exception is ValidationException) {
      return ValidationFailure(exception.message, errors: exception.errors);
    }
    if (exception is UnauthorizedException) {
      return UnauthorizedFailure(exception.message);
    }
    if (exception is ForbiddenException) {
      return ForbiddenFailure(exception.message);
    }
    if (exception is NotFoundException) {
      return NotFoundFailure(exception.message);
    }
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    }
    if (exception is CacheException) {
      return CacheFailure(exception.message);
    }
    if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    }
    return const NetworkFailure(AppConstants.networkExceptionMessage);
  }
}