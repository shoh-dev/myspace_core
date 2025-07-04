// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'result.dart';

typedef CommandActionNoParam<T> = Future<Result<T>> Function();
typedef CommandActionParam<T, A> = Future<Result<T>> Function(A);

/// Facilitates interaction with a ViewModel.
///
/// Encapsulates an action,
/// exposes its running and error states,
/// and ensures that it can't be launched again until it finishes.
///
/// Use [CommandNoParam] for actions without arguments.
/// Use [CommandParam] for actions with one argument.
///
/// Actions must return a [Result].
///
/// Consume the action result by listening to changes,
/// then call to [clearResult] when the state is consumed.
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  int called = 0;

  /// True when the action is running.
  bool get isRunning => _running;

  Result<T>? _result;

  /// true if action completed with error
  bool get isError => _result is ResultError;

  /// true if action completed successfully
  bool get isOk => _result is ResultOk;

  /// Get last action result
  Result<T>? get result => _result;

  T? get value => result?.fold((value) => value, (error) => null);

  /// Get error message
  String get errorMessage => _result?.fold((p0) => '', (p0) => p0) ?? '';

  /// Clear last action result
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Internal execute implementation
  Future<Result<T>?> _execute(CommandActionNoParam<T> action) async {
    // Ensure the action can't launch multiple times.
    // e.g. avoid multiple taps on button
    if (_running) return null;

    // Notify listeners.
    // e.g. button shows loading state
    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Result.error(e);
    } finally {
      _running = false;
      called += 1;
      notifyListeners();
    }
    return _result;
  }
}

/// [Command] without arguments.
/// Takes a [CommandActionNoParam] as action.
class CommandNoParam<T> extends Command<T> {
  CommandNoParam(this._action);

  final CommandActionNoParam<T> _action;

  /// Executes the action.
  ///
  /// If returns null this means it is still running
  Future<Result<T>?> execute() async {
    return await _execute(_action);
  }
}

/// [Command] with one argument.
/// Takes a [CommandActionParam] as action.
class CommandParam<T, A> extends Command<T> {
  CommandParam(this._action);

  final CommandActionParam<T, A> _action;

  /// Executes the action with the argument.
  ///
  /// If returns null this means it is still running
  Future<Result<T>?> execute(A argument) async {
    return await _execute(() => _action(argument));
  }
}
