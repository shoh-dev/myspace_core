// import 'package:logging/logging.dart';

// final locator = ServiceLocator.instance;

// class ServiceLocator {
//   final _log = Logger("ServiceLocator");

//   static final ServiceLocator instance = ServiceLocator._();
//   ServiceLocator._();

//   final Map<Type, dynamic> _services = {};

//   void registerSingleton<T>(T instance) {
//     _services[T] = instance;
//     _log.info("Registered $T");
//   }

//   T get<T>() {
//     _log.info("Getting $T");
//     return _services[T] as T;
//   }
// }
