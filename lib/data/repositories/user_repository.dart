import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_providers/authentiation_api.dart';

class UserRepository {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();
  late SharedPreferences _sharedPreferences;

  UserRepository() {
    _initializeUserRepository();
  }

  Future _initializeUserRepository() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // to authenticate new user by creating account
  Future<dynamic> signupAndAuthenticate({
    required Map<dynamic, dynamic> signupData,
  }) async {
    return await _authenticationAPI.signup(signupData: signupData);
  }

  // to authenticate existing user by loging in
  Future<dynamic> loginAndAuthenticate({
    required Map<dynamic, dynamic> loginData,
  }) async {
    return await _authenticationAPI.login(loginData: loginData);
  }

  // check for token validity at app start
  Future<bool> hasValidToken() async {
    // 1) get token from local storage
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    // 2) validate token from server
    try {
      final validationResponse = await _authenticationAPI.isTokenValid(
        token: token,
      );

      if (validationResponse.data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // ? how to respond to user about this
      return false;
    }
  }

  // to persist data after successfull login
  Future<void> persistData({
    required Map<dynamic, dynamic> userData,
  }) async {
    // storing token to secure storage
    await _flutterSecureStorage.write(
      key: 'JWT_TOKEN',
      value: userData['token'],
    );

    // storing name in shared preferences
    await _sharedPreferences.setString('FIRST_NAME', userData['name']);
  }

  // to delete data after logout
  Future<void> deleteData() async {
    await _flutterSecureStorage.deleteAll();
    await _sharedPreferences.remove('name');
  }
}
