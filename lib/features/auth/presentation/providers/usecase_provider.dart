import 'package:client/core/network/dio_client.dart';
import 'package:client/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/datasources/remote_datasource.dart';
import '../../data/datasources/local_datasource.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/repositories/auth_repo.dart';

final dioProvider = Provider<Dio>((ref) =>  DioClient.createDio());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(ref.read(dioProvider)),
);

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSourceImpl(),
);

final authRepositoryProvider = Provider<AuthRepo>(
  (ref) => AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  ),
);

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

final registerUseCaseProvider = Provider<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider))
);