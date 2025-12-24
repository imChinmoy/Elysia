import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
    String email,
    String password,
    String username,
    String phoneNumber,
    String role,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      log(dio.options.baseUrl);
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      log(response.data.toString());
      final userJson = response.data['user'] as Map<String, dynamic>;
      final token = response.data['token'] as String?;

      return UserModel(
        id: userJson['id'] as String,
        email: userJson['email'] as String,
        username: userJson['username'] as String,
        role: userJson['role'] as String?,
        token: token,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String username,
    String phoneNumber,
    String role,
  ) async {
    try {
      log(dio.options.baseUrl);
      final response = await dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'username': username,
          'phoneNumber': phoneNumber,
          'role': role,
        },
      );
      log(response.data.toString());
      final userJson = response.data['user'] as Map<String, dynamic>;
      final token = response.data['token'] as String?;

      return UserModel(
        id: userJson['id'],
        email: userJson['email'],
        username: userJson['username'],
        role: userJson['role'],
        token: token,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
