abstract class ReducerCore<T> {
  T reducer(T state, UpdateStateReducer action);
}

abstract class UpdateStateReducer<St> {
  const UpdateStateReducer();

  St rebuildState(St oldState);
}
