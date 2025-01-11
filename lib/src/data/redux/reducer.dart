abstract class AppReducer<T> {
  T reducer(T state, UpdateStateReducer action);
}

abstract class UpdateStateReducer<St> {
  const UpdateStateReducer();

  St rebuildState(St oldState);
}
