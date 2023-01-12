import 'package:dio/dio.dart';

class AuthenticationAPI {
  final String baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/users';

  Future<dynamic> signup({
    required Map<dynamic, dynamic> signupData,
  }) async {
    return await Dio().post('$baseUrl/signup', data: signupData);
  }

  Future<dynamic> login({
    required Map<dynamic, dynamic> loginData,
  }) async {
    return await Dio().post('$baseUrl/signin', data: loginData);
  }

  Future<dynamic> isTokenValid({required String token}) async {
    return await Dio().post(
      '$baseUrl/validateLogin',
      options: Options(headers: {'authorization': token}),
    );
  }
}
