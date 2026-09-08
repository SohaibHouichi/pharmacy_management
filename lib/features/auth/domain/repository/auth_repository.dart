import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/auth/data/models/requests/auth_request.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(AuthRequest authRequest);
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}