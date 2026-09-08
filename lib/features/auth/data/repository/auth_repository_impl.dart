import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/core/error/guard.dart';
import 'package:pharmacy_management/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:pharmacy_management/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:pharmacy_management/features/auth/data/models/requests/auth_request.dart';
import 'package:pharmacy_management/features/auth/data/models/responses/auth_me_response.dart';
import 'package:pharmacy_management/features/auth/data/models/responses/auth_response.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';
import 'package:pharmacy_management/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  AuthRepositoryImpl({
    required this._remote,
    required this._local,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(AuthRequest request) {
    return guard(() async {
      final response = await _remote.login(request);
      await _local.cacheAuthToken(response.data.token);
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    return guard(() async {
      final response = await _remote.getCurrentUser();
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> logout() {
    return guard(() async {
      try {
        await _remote.logout();
      } finally {
        await _local.clearCachedAuthToken();
      }
    });
  }
}