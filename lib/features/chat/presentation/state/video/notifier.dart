import 'package:client/features/chat/data/models/call_model.dart';
import 'package:client/features/chat/domain/usecases/end_usecase.dart';
import 'package:client/features/chat/domain/usecases/init_usecase.dart';
import 'package:client/features/chat/domain/usecases/start_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallNotifier extends StateNotifier<CallState> {
  final InitUseCase initCall;
  final StartUseCase startCall;
  final EndUseCase endCall;

  CallNotifier({
    required this.initCall,
    required this.startCall,
    required this.endCall,
  }) : super(const CallState.initial());

  Future<void> init(String roomId) async {
    state = state.copyWith(status: CallStatus.initializing);

    final failure = await initCall.call(roomId);
    if (failure != null) {
      state = state.copyWith(status: CallStatus.error, error: failure.message);
    } else {
      state = state.copyWith(status: CallStatus.ready);
    }
  }

  Future<void> start(String roomId) async {
    state = state.copyWith(status: CallStatus.calling);

    final failure = await startCall.call(roomId);
    if (failure != null) {
      state = state.copyWith(status: CallStatus.error, error: failure.message);
    } else {
      state = state.copyWith(status: CallStatus.connected);
    }
  }

  Future<void> end(String roomId) async {
    await endCall.call(roomId);
    state = const CallState.initial();
  }
}
