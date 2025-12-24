enum CallStatus { idle, initializing, ready, calling, connected, ended, error }

class CallState {
  final CallStatus status;
  final String? error;

  const CallState({required this.status, this.error});

  const CallState.initial() : status = CallStatus.idle, error = null;

  CallState copyWith({CallStatus? status, String? error}) {
    return CallState(status: status ?? this.status, error: error);
  }

  bool get isIdle => status == CallStatus.idle;
  bool get isInitializing => status == CallStatus.initializing;
  bool get isReady => status == CallStatus.ready;
  bool get isCalling => status == CallStatus.calling;
  bool get isConnected => status == CallStatus.connected;
  bool get hasError => status == CallStatus.error;
}
