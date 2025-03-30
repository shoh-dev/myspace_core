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

extension ResultHelper<T> on Result<T> {
  bool get isOk => this is ResultOk;
  bool get isError => this is ResultError;

  ResultOk<T> get asOk => this as ResultOk<T>;
  ResultError get asError => this as ResultError;
}
