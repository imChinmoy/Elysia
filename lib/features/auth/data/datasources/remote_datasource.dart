import 'package:client/features/auth/data/models/userModel.dart';
import 'package:client/features/auth/domain/Failure/auth_failure.dart';
import 'package:dio/dio.dart';

class RemoteDatasource {
  final Dio dio;
  RemoteDatasource(this.dio);
  
  Future<(UserModel?, AuthFailure?)> login({required email, required password}) async {

    final payloads = {
      'email': email,
      'password': password,
    };

    final res = await dio.post('/login', data:payloads);
    if (res.statusCode == 200) {
      final user = UserModel.fromJson(res.data);
      return (user, null);
    } else {
      return (null, UnknownError());
    }
  }

  Future<(UserModel?, AuthFailure?)> register({required email, required password, required username, required phoneNumber}) async {
    
    final payloads ={
      'email': email,
      'password': password,
      'username': username,
      'phone_number': phoneNumber,
    };
    final res = await dio.post('register', data: payloads);

    if (res.statusCode ==201){
      final user = UserModel.fromJson(res.data);
      return (user, null);
    }
    else if (res.statusCode == 400){
      return (null, InvalidCredentials());
    }
    else{
      return (null, UnknownError());
    }
  }

}