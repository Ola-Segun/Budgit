/// Base failure class for all domain errors
abstract class Failure {
  const Failure();

  /// Network-related failures
  const factory Failure.network(String message) = NetworkFailure;

  /// Server-side failures
  const factory Failure.server(String message, int? statusCode) = ServerFailure;

  /// Local storage/cache failures
  const factory Failure.cache(String message) = CacheFailure;

  /// Validation failures
  const factory Failure.validation(String message, Map<String, dynamic> errors) = ValidationFailure;

  /// Not found failures (resource doesn't exist)
  const factory Failure.notFound(String message) = NotFoundFailure;

  /// Unknown/unexpected failures
  const factory Failure.unknown(String message) = UnknownFailure;

  String get message;
}

/// Network failure (connection issues, timeouts, etc.)
class NetworkFailure extends Failure {
  const NetworkFailure(this.message);

  @override
  final String message;
}

/// Server failure (API errors, 4xx/5xx responses)
class ServerFailure extends Failure {
  const ServerFailure(this.message, this.statusCode);

  @override
  final String message;
  final int? statusCode;
}

/// Cache/local storage failure
class CacheFailure extends Failure {
  const CacheFailure(this.message);

  @override
  final String message;
}

/// Validation failure (user input validation)
class ValidationFailure extends Failure {
  const ValidationFailure(this.message, this.errors);

  @override
  final String message;
  final Map<String, dynamic> errors;
}

/// Not found failure (resource doesn't exist)
class NotFoundFailure extends Failure {
  const NotFoundFailure(this.message);

  @override
  final String message;
}

/// Unknown/unexpected failure
class UnknownFailure extends Failure {
  const UnknownFailure(this.message);

  @override
  final String message;
}