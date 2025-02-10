import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_core/src/data/dependency_injection/dependency_injection.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:redux/redux.dart';

Map<Type, DefaultAction> _runningActions = {};

///[St] is the root state type
///[R] is the return type
abstract class DefaultAction<St extends Equatable, R> {
  const DefaultAction();

  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  //Call this method in redux middleware
  bool get isRunning => _runningActions.containsKey(runtimeType);

  FutureOr<R> payload(St state, NextDispatcher next); //handle return type

  Store<St> get _store => getDependency<Store<St>>();

  //Call this method from UI
  FutureOr<R> execute() {
    if (_runningActions.containsKey(runtimeType)) {
      log('[$runtimeType] RUNNING ALREADY');
      throw Exception('Action is already running');
    }

    _runningActions[runtimeType] = this;
    log('[$runtimeType] CALL');

    final result = _store.dispatch(this);

    _runningActions.remove(runtimeType);

    return result;
  }
}

abstract class AsyncDefaultAction<St extends Equatable, R>
    extends DefaultAction<St, R> {
  const AsyncDefaultAction();

  //Call this method in redux middleware
  @override
  Future<R> payload(St state, NextDispatcher next); //handle return type

  //Call this method from UI
  @override
  Future<R> execute([bool showLoadingIndicator = false]) async {
    VoidCallback? cancelLoadingIndicator;
    if (showLoadingIndicator) cancelLoadingIndicator = showLoadingDialog();
    final result = await super.execute();
    if (showLoadingIndicator) cancelLoadingIndicator?.call();

    return result;
  }
}

abstract class SyncDefaultAction<St extends Equatable, R>
    extends DefaultAction<St, R> {
  const SyncDefaultAction();

  //Call this method in redux middleware
  @override
  R payload(St state, NextDispatcher next);

  //Call this method from UI
  @override
  R execute() {
    final result = super.execute();
    return result as R;
  }
}
