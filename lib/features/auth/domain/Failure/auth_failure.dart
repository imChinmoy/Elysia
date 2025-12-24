sealed class AuthFailure {
  final String message;
  AuthFailure(this.message);
}

class InvalidCredentials extends AuthFailure {
  InvalidCredentials() : super('Invalid Credentials Provided');
}

class NetworkError extends AuthFailure {
  NetworkError() : super('Network Error Occurred');
}

class UnknownError extends AuthFailure {
  UnknownError() : super('An Unknown Error Occurred');
}
