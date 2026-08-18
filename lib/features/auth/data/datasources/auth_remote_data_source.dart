import 'package:exercise_5_8_26/core/network/dio_client.dart';
import 'package:exercise_5_8_26/features/auth/data/models/login_response_model.dart';

class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String username, String password) async {
    final response = await DioClient.dio.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );

    return LoginResponseModel.fromJson(response.data);
  }
}
