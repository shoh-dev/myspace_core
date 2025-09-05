import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class ResultWrapper<T> extends StatelessWidget {
  const ResultWrapper({
    super.key,
    required this.result,
    required this.onOk,
    required this.onError,
  });

  final Result<T> result;
  final Widget Function(BuildContext context, T data) onOk;
  final Widget Function(BuildContext context, String message) onError;

  @override
  Widget build(BuildContext context) {
    final r = result;
    switch (r) {
      case ResultOk<T>():
        return onOk(context, r.value);
      case ResultError<T>():
        return onError(context, r.errorMessage);
    }
  }
}

class UIResultWrapper<T> extends StatelessWidget {
  const UIResultWrapper({
    super.key,
    required this.result,
    required this.onOk,
    this.onError,
    this.onInitial,
    this.onLoading,
  });

  final UIResult<T> result;
  final Widget Function(BuildContext context, T data) onOk;
  final Widget Function(BuildContext context, String message)? onError;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context)? onInitial;

  @override
  Widget build(BuildContext context) {
    final r = result;
    switch (r) {
      case UIResultOk<T>():
        return onOk(context, r.value);
      case UIResultError<T>():
        return onError != null
            ? onError!(context, r.error)
            : ErrorDialog(content: r.error);
      case UIResultLoading<T>():
        return onLoading != null ? onLoading!(context) : const LoadingDialog();
      case UIResultInitial<T>():
        return onInitial != null
            ? onInitial!(context)
            : const SizedBox.shrink();
    }
  }
}
