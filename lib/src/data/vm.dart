import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';

abstract class Vm extends ChangeNotifier {
  bool isDisposed = false;

  Vm();

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    log("Called dispose() for $runtimeType VM");
  }

  int counter = 0;

  void incrementCounter() {
    counter += 1;
    notifyListeners();
  }
}

class VmProvider extends StatelessWidget {
  const VmProvider({
    super.key,
    required this.vm,
    required this.builder,
  });

  final Vm vm;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => builder(context),
    );
  }
}

class AppStoreProvider<St extends CoreAppStore> extends StatelessWidget {
  const AppStoreProvider({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, St store) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      context.watchAppStore<St>(),
    );
  }
}
