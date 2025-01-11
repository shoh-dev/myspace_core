import 'package:myspace_core/myspace_core.dart';
import 'package:redux/redux.dart';

class AppMiddleware<St> {
  const AppMiddleware();
  dynamic call(Store<St> store, dynamic action, NextDispatcher next) {
    if (action is AsyncDefaultAction || action is SyncDefaultAction) {
      return action.payload(store.state, next);
    }
    return next(action);
  }
}
