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

  static bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  static void unregister<T extends Object>() {
    _getIt.unregister<T>();
  }
}
