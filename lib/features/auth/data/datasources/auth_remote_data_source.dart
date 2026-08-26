import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/features/auth/data/models/current_user_model.dart';
import 'package:exercise_5_8_26/features/auth/data/models/login_response_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<LoginResponseModel> login(String username, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );

    return LoginResponseModel.fromJson(response.data);
  }

  Future<CurrentUserModel> getCurrentUser() async {
    final response = await _dio.get('/auth/me');

    return CurrentUserModel.fromJson(response.data);
  }
}
