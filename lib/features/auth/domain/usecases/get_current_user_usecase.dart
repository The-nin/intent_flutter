import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<Failure, AuthUser>> call({
    required String accessToken,
    required String refreshToken,
  }) {
    return repository.getCurrentUser(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
