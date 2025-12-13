import 'package:client/features/auth/data/datasources/remote_datasource.dart';
import 'package:client/features/auth/data/models/userModel.dart';
import 'package:client/features/auth/domain/Failure/auth_failure.dart';
import 'package:client/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo{

  final RemoteDatasource _remoteData;

  AuthRepoImpl(this._remoteData);

  @override
  Future<(UserModel?, AuthFailure?)> login(email, password, phoneNumber) async {
    try{
      final user = await _remoteData.login(email: email, password: password);
      return user;
    }
    catch(e){
      return (null, UnknownError());
    }
  }

  @override
  Future<(UserModel?, AuthFailure?)> register(email, password, username, phoneNumber) async {

    try{
      final user = await _remoteData.register(email: email, password: password, username: username, phoneNumber: phoneNumber);
      return user;
    }
    catch(e){
      return (null, UnknownError());
    }
  }

}