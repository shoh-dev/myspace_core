/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [ResultOk] with a value of type [T]
/// or an [ResultError] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = ResultOk._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(ResultException error) = ResultError._;

  @override
  String toString() => 'Result<$T>';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result<T>;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A successful [Result] with a returned [value].
final class ResultOk<T> extends Result<T> {
  const ResultOk._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultOk<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// An error [Result] with a resulting [error].
final class ResultError<T> extends Result<T> {
  const ResultError._(this.error);

  /// The resulting error of this result.
  final ResultException error;

  @override
  String toString() => 'Result<$T>.error($error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultError<T> && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class ResultException implements Exception {
  final dynamic message;

  ResultException(this.message);

  @override
  String toString() => message.toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

extension ResultHelper on Result {
  bool get isOk => this is ResultOk;
  bool get isError => this is ResultError;

  ResultOk get asOk => this as ResultOk;
  ResultError get asError => this as ResultError;
}
