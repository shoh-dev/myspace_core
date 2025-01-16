import 'dart:developer';

import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static final _getIt = GetIt.instance;

  static void register<T extends Object>(T di) {
    if (_getIt.isRegistered<T>()) {
      _getIt.unregister<T>();
    }
    _getIt.registerLazySingleton<T>(() => di);

    log("Registered $T");
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
