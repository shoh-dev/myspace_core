import 'package:myspace_core/myspace_core.dart';

sealed class UIResult<T> {
  const UIResult();

  factory UIResult.ok(T value) {
    return UIResultOk<T>(value);
  }

  factory UIResult.error(String error, {String? code, StackTrace? stackTrace}) {
    return UIResultError<T>(error, code: code, stackTrace: stackTrace);
  }

  //fromUIResultError
  factory UIResult.fromUIResultError(UIResultError<T> error) {
    return UIResultError<T>(
      error.error,
      code: error.code,
      stackTrace: error.stackTrace,
    );
  }

  factory UIResult.loading() {
    return UIResultLoading<T>();
  }

  factory UIResult.initial() {
    return UIResultInitial<T>();
  }

  factory UIResult.fromResult(Result<T> result) {
    switch (result) {
      case ResultOk():
        return UIResultOk<T>(result.value);
      case ResultError():
        return UIResultError<T>(
          result.errorMessage,
          code: result.code,
          stackTrace: result.stackTrace,
        );
    }
  }
}

class UIResultOk<T> extends UIResult<T> {
  final T value;

  const UIResultOk(this.value);
}

class UIResultError<T> extends UIResult<T> {
  final String error;
  final String? code;
  final StackTrace? stackTrace;

  const UIResultError(this.error, {this.code, this.stackTrace});
}

class UIResultLoading<T> extends UIResult<T> {
  const UIResultLoading();
}

class UIResultInitial<T> extends UIResult<T> {
  const UIResultInitial();
}

extension UIResultHelpers<T> on UIResult<T> {
  bool get isOk => this is UIResultOk<T>;

  bool get isError => this is UIResultError<T>;

  bool get isLoading => this is UIResultLoading<T>;

  bool get isInitial => this is UIResultInitial<T>;
}
