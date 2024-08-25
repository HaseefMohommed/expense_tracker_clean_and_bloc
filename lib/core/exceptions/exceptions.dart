class ServerException implements Exception {}

class InternetException implements Exception {}

class AuthenticationException implements Exception {
  final String? code;

  AuthenticationException({this.code});
}

class UnexpectedException implements Exception {}

class LocalException implements Exception {
  final String message;
  LocalException(this.message);
}
