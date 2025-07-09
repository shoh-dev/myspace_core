import 'dart:async';

import 'package:flutter/foundation.dart';

import 'dart:developer' as dev;

typedef AppStoreEmitter<S> = void Function(S newState, [bool notify]);

abstract class CoreAppStore<E extends CoreAppStoreEvent, S>
    extends ChangeNotifier {
  S _state;
  S get state => _state;

  CoreAppStore(this._state) {
    onInit();
  }

  @mustCallSuper
  void onInit() {
    dev.log("onInit()", name: runtimeType.toString());
  }

  @protected
  Future<void> onEvent(E event, AppStoreEmitter<S> emit);

  void _emit(S newState, [bool notify = true]) {
    if (state != newState) {
      _state = newState;
      if (notify) {
        notifyListeners();
      }
    }
  }

  @nonVirtual
  Future<void> addEvent(E event) {
    dev.log("addEvent(): ${event.runtimeType}", name: runtimeType.toString());
    return onEvent(event, _emit);
  }

  @nonVirtual
  Future<void> addEvents(List<E> events) async {
    for (final event in events) {
      await addEvent(event);
    }
  }
}

abstract class CoreAppStoreEvent<T> {
  final completer = Completer<T>();
}
