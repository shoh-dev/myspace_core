import 'dart:developer';

import 'package:myspace_core/myspace_core.dart';
import 'package:redux/redux.dart';

Map<Type, DefaultAction> _runningActions = {};

Store? applicationStore; //todo: implement

abstract class DefaultAction<St> {
  const DefaultAction();

  //Call this method in redux middleware
  bool get isRunning => _runningActions.containsKey(runtimeType);
}

abstract class AsyncDefaultAction<St> extends DefaultAction<St> {
  const AsyncDefaultAction();

  //Call this method in redux middleware
  Future<Result> payload(St state, NextDispatcher next); //handle return type

  //Call this method from UI
  Future<Result> execute([bool showLoadingIndicator = false]) async {
    if (_runningActions.containsKey(runtimeType)) {
      log('Action is already running');
      return Result.error(ResultException('Action is already running'));
    }

    _runningActions[runtimeType] = this;
    log('Action is running now');
    if (showLoadingIndicator) {
      //todo: show loading indicator
    }
    final result = await applicationStore?.dispatch(this);
    if (showLoadingIndicator) {
      //todo: hide loading indicator
    }
    _runningActions.remove(runtimeType);
    log('Action is finished');
    return result;
  }
}

abstract class SyncDefaultAction<St> extends DefaultAction<St> {
  const SyncDefaultAction();

  //Call this method in redux middleware
  Result payload(St state, NextDispatcher next);

  //Call this method from UI
  Result execute() {
    final result = applicationStore?.dispatch(this);
    return result;
  }
}
