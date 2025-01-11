import 'package:redux/redux.dart';

abstract class AppReducer<T> {
  T reducer(T state, dynamic action);
}

abstract interface class UpdateStateReducer<St, A> {
  const UpdateStateReducer();

  St rebuildState(St state, A action);

  Reducer<St> get reducer;
}
