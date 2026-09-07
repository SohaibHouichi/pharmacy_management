class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException({required this.message});
}

class ForbiddenException implements Exception {
  final String message;
  const ForbiddenException({required this.message});
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException({required this.message});
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;
  const ValidationException({required this.message, this.errors});
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({required this.message});
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});
}