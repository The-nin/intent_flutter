import 'package:exercise_5_8_26/core/network/dio_client.dart';
import '../models/login_response.dart';

class AuthService {
  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await DioClient.dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
