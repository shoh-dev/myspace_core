import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'dart:developer' as dev;

typedef VmEmitter<S> = void Function(S newState, [bool notify]);

abstract class Vm<E extends VmEvent, S> extends ChangeNotifier {
  late final log = Logger(runtimeType.toString());
  bool isDisposed = false;

  S _state;
  S get state => _state;

  Vm(this._state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onInit();
    });
  }

  @protected
  Future<void> onEvent(E event, VmEmitter<S> emit);

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
    // return Future.wait(events.map(addEvent));
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    dev.log("dispose()", name: runtimeType.toString());
  }

  @protected
  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  void onInit() {
    dev.log("onInit()", name: runtimeType.toString());
  }
}

abstract class VmEvent<T> {
  final completer = Completer<T>();
}
