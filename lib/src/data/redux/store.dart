import 'package:myspace_core/src/data/redux/middleware.dart';
import 'package:myspace_core/src/data/redux/reducer.dart';
import 'package:redux/redux.dart';

class AppStore<T> {
  final T initialState;
  final AppReducer<T> reducer;
  final AppMiddleware middleware;

  AppStore({
    required this.initialState,
    required this.reducer,
    required this.middleware,
  });

  Store<T> createStore() {
    return Store<T>(
      reducer.reducer,
      distinct: true,
      initialState: initialState,
      middleware: [
        middleware.call,
      ],
    );
  }
}
