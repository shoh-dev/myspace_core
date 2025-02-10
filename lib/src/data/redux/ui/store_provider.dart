import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myspace_core/src/data/dependency_injection/dependency_injection.dart';
import 'package:redux/redux.dart';

class AppStoreProvider<St extends Object> extends StatelessWidget {
  final Store<St> store;
  final Widget child;

  const AppStoreProvider({
    super.key,
    required this.store,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final storeExists = DependencyInjection.isRegistered<St>();

    if (storeExists) {
      throw Exception(
          'StoreProvider must be uses only once in the top of the widget tree!');
    }
    return StoreProvider(store: store, child: child);
  }
}
