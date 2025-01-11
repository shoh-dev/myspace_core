abstract class AppReducer<T> {
  T reducer(T state, dynamic action);
}

abstract class StateReducer<ST, A> {
  const StateReducer();

  ST reducer(ST state, A action);
}
