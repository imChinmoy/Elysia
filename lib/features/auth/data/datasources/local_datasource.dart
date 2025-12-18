import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>('users');
    await box.put('current_user', user);
  }

  @override
  Future<UserModel?> getUser() async {
    final box = await Hive.openBox<UserModel>('users');
    return box.get('current_user');
  }

  @override
  Future<void> saveToken(String token) async {
    final box = await Hive.openBox('auth');
    await box.put('token', token);
  }

  @override
  Future<String?> getToken() async {
    final box = await Hive.openBox('auth');
    return box.get('token');
  }

  @override
  Future<void> clearData() async {
    final userBox = await Hive.openBox<UserModel>('users');
    final authBox = await Hive.openBox('auth');
    await userBox.clear();
    await authBox.clear();
  }
}
