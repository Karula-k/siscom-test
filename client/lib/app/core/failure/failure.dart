import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ExceptionFailure extends Failure {
  const ExceptionFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ClientFailure extends Failure {
  const ClientFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class ForbidenFailure extends Failure {
  const ForbidenFailure(super.message);
}
