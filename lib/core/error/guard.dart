import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
/// Runs a repository action and converts any thrown exception into a Failure.
Future<Either<Failure, T>> guard<T>(Future<T> Function() action) async {
  try {
    return Right(await action());
  } catch (e) {
    return Left(FailureHandler.fromException(e));
  }
}