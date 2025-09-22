import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class NewPageVm extends Vm<EmptyVmEvent, EmptyVmState> {
  NewPageVm() : super(EmptyVmState.initial());

  @override
  Future<void> onEvent(EmptyVmEvent event, VmEmitter<EmptyVmState> emit) async {
    // No events to handle
  }
}

class SplashPageVm extends Vm<SplashPageEvent, SplashPageState> {
  SplashPageVm() : super(SplashPageState.initial());

  @override
  Future<void> onEvent(
    SplashPageEvent event,
    VmEmitter<SplashPageState> emit,
  ) async {
    switch (event) {
      case IncrementCounterEvent():
        //may call api
        emit(state.copyWith(counter: state.counter + event.incrementBy));
        break;
      case DecrementCounterEvent():
        emit(state.copyWith(counter: state.counter - event.decrementBy));
        break;
      case RandomNumberEvent():
        final cancel = LoadingDialog.show();
        try {
          final dio = Dio();
          final response = await dio.get(
            'http://www.randomnumberapi.com/api/v1.0/random?min=1&max=100',
          );
          if (response.statusCode != 200) {
            log('Failed to fetch random number: ${response.statusCode}');
            cancel();
            return;
          }
          final data = (response.data as List).firstOrNull;
          emit(state.copyWith(counter: data ?? 0));
          // event.completer.complete(data);
        } catch (e) {
          ErrorDialog.show(
            e.toString(),
            actionText: 'Retry',
            onClose: (close) {
              addEvent(event);
              close();
            },
          );
        } finally {
          cancel();
        }
        break;
    }
  }
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
