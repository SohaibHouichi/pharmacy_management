import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/auth/data/model/requests/auth_request.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';
import 'package:pharmacy_management/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<Failure, AuthEntity>> call(AuthRequest authRequest) {
    return _authRepository.login(authRequest);
  }
}