import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthUser>> login(String username, String password) async {
    try {
      final response = await remoteDataSource.login(username, password);
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final response = await remoteDataSource.getCurrentUser();
      return Right(response.toEntity(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
