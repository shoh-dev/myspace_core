import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'dart:developer' as dev;

import 'package:mutex/mutex.dart';

typedef VmEmitter<S> = void Function(S newState, [bool notify]);

class EmptyVmState {
  const EmptyVmState();

  factory EmptyVmState.initial() => const EmptyVmState();
}

class EmptyVmEvent extends VmEvent<void> {
  EmptyVmEvent();
}

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

  final _eventMutexGuards = <Type, Mutex>{};

  void _cancelAllEvents() {
    _eventMutexGuards.forEach((key, mutex) {
      if (mutex.isLocked) {
        mutex.release();
      }
    });
  }

  @nonVirtual
  Future<void> addEvent(E event) {
    dev.log("addEvent(): ${event.runtimeType}", name: '$runtimeType');

    if (event.isGuarded == false) {
      dev.log(
        "Event ${event.runtimeType} is not guarded, processing without mutex.",
        name: '$runtimeType',
      );
      return onEvent(event, _emit);
    }

    final mutex = _eventMutexGuards.putIfAbsent(
      event.runtimeType,
      () => Mutex(),
    );

    if (mutex.isLocked) {
      dev.log(
        "Event ${event.runtimeType} is already being processed, skipping.",
        name: '$runtimeType',
      );
      return Future.value();
    }
    return mutex.protect(() => onEvent(event, _emit));
  }

  @nonVirtual
  Future<void> addEvents(List<E> events) async {
    for (final event in events) {
      await addEvent(event);
    }
  }

  @mustCallSuper
  @override
  void dispose() {
    _cancelAllEvents();
    isDisposed = true;
    dev.log("dispose()", name: runtimeType.toString());
    super.dispose();
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
  final bool isGuarded;

  VmEvent({this.isGuarded = true});

  final completer = Completer<T>();
}
