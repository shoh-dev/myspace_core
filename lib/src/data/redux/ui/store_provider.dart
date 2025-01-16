import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myspace_core/src/data/redux/action.dart';
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
    // ignore: invalid_use_of_visible_for_testing_member
    applicationStore = store;
    return StoreProvider(store: store, child: child);
  }
}
