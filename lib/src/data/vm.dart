import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'dart:developer' as dev;

typedef VmEmitter<S> = void Function(S newState, [bool notify]);

abstract class Vm<E extends VmEvent, S> extends ChangeNotifier {
  late final log = Logger(runtimeType.toString());
  bool isDisposed = false;

  S _state;
  S get state => _state;

  Vm(this._state) {
    onInit();
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
  void addEvent(E event) {
    dev.log("addEvent() for $runtimeType VM with event: ${event.runtimeType}");
    unawaited(onEvent(event, _emit));
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    dev.log("dispose() for $runtimeType VM");
  }

  @protected
  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  void onInit() {
    dev.log("onInit() for $runtimeType VM");
  }
}

abstract class VmEvent<T> {
  final completer = Completer<T>();
}
