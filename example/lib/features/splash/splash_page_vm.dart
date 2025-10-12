import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class SplashPageVm extends Vm<SplashPageEvent, SplashPageState> {
  SplashPageVm() : super(SplashPageState.initial());

  @override
  Future<void> onEvent(
    SplashPageEvent event,
    VmEmitter<SplashPageState> emit,
  ) async {
    // No events to handle
    switch (event) {
      case IncrementCounterEvent():
        return _increment(emit);
      case DecrementCounterEvent():
        return _decrement(emit);
      case RandomNumberEvent():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _increment(VmEmitter<SplashPageState> emit) async {
    log('Start _increment');
    // await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
    log('End _increment');
  }

  Future<void> _decrement(VmEmitter<SplashPageState> emit) async {
    log('Start _decrement');
    await Future.delayed(const Duration(seconds: 5));
    emit(state.copyWith(counter: state.counter - 1));
    log('End _decrement');
  }

  // void _increment(VmEmitter<SplashPageState> emit) {
  //   log('Start _increment');
  //   emit(state.copyWith(counter: state.counter + 1));
  //   log('End _increment');
  // }

  // void _decrement(VmEmitter<SplashPageState> emit) {
  // log('Start _decrement');
  // emit(state.copyWith(counter: state.counter - 1));
  // log('End _decrement');
  // }
}

class SplashPageState {
  final int counter;
  final int counter2;

  const SplashPageState({this.counter = 0, this.counter2 = 0});

  factory SplashPageState.initial() => SplashPageState();

  SplashPageState copyWith({int? counter, int? counter2}) {
    return SplashPageState(
      counter: counter ?? this.counter,
      counter2: counter2 ?? this.counter2,
    );
  }

  @override
  String toString() {
    return 'SplashPageState(counter: $counter, counter2: $counter2)';
  }
}

sealed class SplashPageEvent<T> extends VmEvent<T> {}

class IncrementCounterEvent extends SplashPageEvent {
  final int incrementBy;

  IncrementCounterEvent(this.incrementBy);
}

class DecrementCounterEvent extends SplashPageEvent {
  final int decrementBy;

  DecrementCounterEvent(this.decrementBy);
}

class RandomNumberEvent extends SplashPageEvent<int> {
  RandomNumberEvent();
}
