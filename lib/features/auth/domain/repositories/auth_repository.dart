import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> login(String username, String password);

  Future<Either<Failure, AuthUser>> getCurrentUser({
    required String accessToken,
    required String refreshToken,
  });
}
