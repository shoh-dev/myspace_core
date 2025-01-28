import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppStoreProvider<St> extends StatelessWidget {
  final Store<St> store;
  final Widget child;

  const AppStoreProvider({
    super.key,
    required this.store,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store, child: child);
  }
}
