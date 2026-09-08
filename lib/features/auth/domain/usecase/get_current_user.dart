import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';
import 'package:pharmacy_management/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _repository;
  GetCurrentUser({required this._repository});

  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.getCurrentUser();
  }
}
