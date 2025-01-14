import 'dart:async';
import 'dart:developer';

import 'package:myspace_core/myspace_core.dart';
import 'package:redux/redux.dart';

Map<Type, DefaultAction> _runningActions = {};

Store? applicationStore;

///[St] is the root state type
///[R] is the return type
abstract class DefaultAction<St, R> {
  const DefaultAction();

  //Call this method in redux middleware
  bool get isRunning => _runningActions.containsKey(runtimeType);

  FutureOr<Result<R>> payload(
      St state, NextDispatcher next); //handle return type

  //Call this method from UI
  FutureOr<Result<R>> execute() {
    if (_runningActions.containsKey(runtimeType)) {
      log('[$runtimeType] is already running');
      return Result.error(ResultException('Action is already running'));
    }

    _runningActions[runtimeType] = this;
    log('[$runtimeType] is running now');

    final result = applicationStore?.dispatch(this);

    _runningActions.remove(runtimeType);
    log('[$runtimeType] is finished');

    return result;
  }
}

abstract class AsyncDefaultAction<St, R> extends DefaultAction<St, R> {
  const AsyncDefaultAction();

  //Call this method in redux middleware
  @override
  Future<Result<R>> payload(St state, NextDispatcher next); //handle return type

  //Call this method from UI
  @override
  Future<Result<R>> execute([bool showLoadingIndicator = false]) async {
    if (showLoadingIndicator) {
      //todo: show loading indicator
    }
    final result = await super.execute();
    if (showLoadingIndicator) {
      //todo: hide loading indicator
    }

    return result;
  }
}

abstract class SyncDefaultAction<St, R> extends DefaultAction<St, R> {
  const SyncDefaultAction();

  //Call this method in redux middleware
  @override
  Result<R> payload(St state, NextDispatcher next);

  //Call this method from UI
  @override
  Result<R> execute() {
    final result = super.execute();
    return result as Result<R>;
  }
}
