import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';
import 'package:provider/provider.dart';

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
    this.child,
  });

  final Vm vm;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: builder,
      child: child,
    );
  }
}

class AppStoreProvider<St extends CoreAppStore> extends StatelessWidget {
  const AppStoreProvider({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, St store, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    log('AppStoreProvider build');
    return Consumer<St>(
      builder: builder,
      child: child,
    );
  }
}
