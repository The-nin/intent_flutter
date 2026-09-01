abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Error']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Error']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication Error']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No Internet Connection']);
}

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}
