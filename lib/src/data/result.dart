import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.ok(T value) = ResultOk;

  const factory Result.error(
    dynamic e, {
    String? code,
    StackTrace? stackTrace,
  }) = ResultError;
}

extension ResultErrorHelper<T> on ResultError<T> {
  String get errorMessage {
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
