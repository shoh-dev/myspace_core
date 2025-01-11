import 'package:myspace_core/src/data/redux/middleware.dart';
import 'package:myspace_core/src/data/redux/reducer.dart';
import 'package:redux/redux.dart';

class AppStore<St> {
  final St initialState;
  final AppReducer<St> reducer;
  final AppMiddleware<St> _middleware;

  AppStore({
    required this.initialState,
    required this.reducer,
  }) : _middleware = AppMiddleware<St>();

  Store<St> createStore() {
    return Store<St>(
      reducer.reducer,
      distinct: true,
      initialState: initialState,
      middleware: [
        _middleware.call,
      ],
    );
  }
}
