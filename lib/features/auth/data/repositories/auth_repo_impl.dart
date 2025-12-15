import 'package:client/core/either.dart';
import 'package:client/features/auth/data/datasources/local_datasource.dart';
import 'package:client/features/auth/data/datasources/remote_datasource.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/failure/auth_failure.dart';
import 'package:client/features/auth/domain/repositories/auth_repo.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AuthFailure, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final userModel = await remoteDataSource.login(email, password);

      if (userModel.token != null) {
        await localDataSource.saveToken(userModel.token!);
      }
      await localDataSource.saveUser(userModel);

      return Right(userModel);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (_) {
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> register(
    String email,
    String password,
    String username,
    String phoneNumber,
    String role,
  ) async {
    try {
      final userModel = await remoteDataSource.register(
        email,
        password,
        username,
        phoneNumber,
        role,
      );

      if (userModel.token != null) {
        await localDataSource.saveToken(userModel.token!);
      }
      await localDataSource.saveUser(userModel);

      return Right(userModel);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (_) {
      return Left(UnknownError());
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearData();
  }

  AuthFailure _handleDioError(DioException e) {
    if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
      return InvalidCredentials();
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkError();
    }
    return UnknownError();
  }
}
