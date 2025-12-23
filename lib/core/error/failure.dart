class Failure {
  final String message;
  final FailureType type;

  const Failure({required this.message, this.type = FailureType.unknown});

  @override
  String toString() => 'Failure(type: $type, message: $message)';
}

enum FailureType { network, permission, timeout, server, webrtc, unknown }
