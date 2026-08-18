import 'package:exercise_5_8_26/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser> login(String username, String password) async {
    final response = await remoteDataSource.login(username, password);

    return response.toEntity();
  }
}
