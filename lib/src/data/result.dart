sealed class Result<T> {
  const Result();

  factory Result.ok(T value) {
    return ResultOk<T>(value);
  }

  factory Result.error(dynamic e, {String? code, StackTrace? stackTrace}) {
    return ResultError<T>(e, code: code, stackTrace: stackTrace);
  }
}

class ResultOk<T> extends Result<T> {
  final T value;

  const ResultOk(this.value);
}

class ResultError<T> extends Result<T> {
  final dynamic e;
  final String? code;
  final StackTrace? stackTrace;

  const ResultError(this.e, {this.code, this.stackTrace});
}

extension ResultErrorHelper<T> on ResultError<T> {
  String get errorMessage {
    if (e is String) return e.toString();

    return switch (e) {
      Exception _ => e.toString().replaceAll('Exception: ', ""),
      TypeError _ => e.toString(),
      _ => 'NOT IMPLEMENTED YET: $this',
    };
  }
}

extension ResultHelper<T> on Result<T> {
  bool get isOk => this is ResultOk;
  bool get isError => this is ResultError;

  //fold method
  R fold<R>(R Function(T value) onOk, R Function(dynamic error) onError) {
    if (isOk) {
      final ok = this as ResultOk<T>;
      return onOk(ok.value);
    }
    final error = this as ResultError<T>;
    return onError(error.errorMessage);
  }
}
