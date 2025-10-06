/// Result type for handling success/error states
/// Always wrap async operations in Result to ensure proper error handling
library;

import 'failures.dart';

sealed class Result<T> {
  const Result();

  /// Create a successful result
  const factory Result.success(T data) = Success<T>;

  /// Create an error result
  const factory Result.error(Failure failure) = Error<T>;

  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is error
  bool get isError => this is Error<T>;

  /// Get data if success, null if error
  T? get dataOrNull => switch (this) {
        Success<T>(data: final data) => data,
        Error<T>() => null,
      };

  /// Get failure if error, null if success
  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Error<T>(failure: final failure) => failure,
      };

  /// Handle result with callbacks
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    return switch (this) {
      Success<T>(data: final data) => success(data),
      Error<T>(failure: final failure) => error(failure),
    };
  }

  /// Transform success data
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(transform(data)),
      Error<T>(failure: final failure) => Result.error(failure),
    };
  }

  /// Transform success data or return default on error
  Result<R> mapOr<R>(R Function(T data) transform, R defaultValue) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(transform(data)),
      Error<T>() => Result.success(defaultValue),
    };
  }

  /// Chain operations on success
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    return switch (this) {
      Success<T>(data: final data) => transform(data),
      Error<T>(failure: final failure) => Result.error(failure),
    };
  }

  /// Get data or throw exception
  T getOrThrow() {
    return switch (this) {
      Success<T>(data: final data) => data,
      Error<T>(failure: final failure) => throw ResultException(failure),
    };
  }

  /// Get data or return default value
  T getOrDefault(T defaultValue) {
    return switch (this) {
      Success<T>(data: final data) => data,
      Error<T>() => defaultValue,
    };
  }
}

/// Success result containing data
class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  String toString() => 'Success($data)';
}

/// Error result containing failure
class Error<T> extends Result<T> {
  const Error(this.failure);

  final Failure failure;

  @override
  String toString() => 'Error($failure)';
}

/// Exception thrown when trying to get data from error result
class ResultException implements Exception {
  const ResultException(this.failure);

  final Failure failure;

  @override
  String toString() => 'ResultException: $failure';
}