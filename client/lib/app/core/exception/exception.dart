class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class ClientException implements Exception {
  final String message;

  ClientException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class ForbidenException implements Exception {
  final String message;

  ForbidenException(this.message);
}
