import 'package:client/features/chat/data/datasource/api_signaling_datasource.dart';
import 'package:client/features/chat/data/datasource/api_webrtc_datasource.dart';
import 'package:client/features/chat/data/models/call_model.dart';
import 'package:client/features/chat/data/repositories/call_repo_impl.dart';
import 'package:client/features/chat/domain/repositories/call_repo.dart';
import 'package:client/features/chat/domain/usecases/end_usecase.dart';
import 'package:client/features/chat/domain/usecases/init_usecase.dart';
import 'package:client/features/chat/domain/usecases/start_usecase.dart';
import 'package:client/features/chat/presentation/state/video/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final socketProvider = Provider<io.Socket>((ref) {
  final socket = io.io(
    'http://localhost:3000',
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  ref.onDispose(socket.disconnect);
  return socket;
});

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final ds = LocalDataSourceImpl();
  ref.onDispose(ds.dispose);
  return ds;
});

final signalingProvider = Provider<SignalingDatasource>((ref) {
  return SignalingDatasource(ref.read(socketProvider));
});

final callRepositoryProvider = Provider<CallRepository>((ref) {
  return CallRepositoryImpl(
    ref.read(localDataSourceProvider),
    ref.read(signalingProvider),
  );
});

final initCallUseCaseProvider = Provider(
  (ref) => InitUseCase(ref.read(callRepositoryProvider)),
);

final startCallUseCaseProvider = Provider(
  (ref) => StartUseCase(ref.read(callRepositoryProvider)),
);

final endCallUseCaseProvider = Provider(
  (ref) => EndUseCase(ref.read(callRepositoryProvider)),
);

final callProvider = StateNotifierProvider<CallNotifier, CallState>((ref) {
  return CallNotifier(
    initCall: ref.read(initCallUseCaseProvider),
    startCall: ref.read(startCallUseCaseProvider),
    endCall: ref.read(endCallUseCaseProvider),
  );
});
