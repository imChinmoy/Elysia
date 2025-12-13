import 'package:client/features/auth/data/models/userModel.dart';
import 'package:client/features/auth/domain/Failure/auth_failure.dart';

abstract class AuthRepo {

  Future<(UserModel?, AuthFailure?)> login(email, password, phoneNumber);
  Future<(UserModel?, AuthFailure?)> register(email, password, username, phoneNumber);

}
