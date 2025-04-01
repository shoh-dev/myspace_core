import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';

abstract class Vm<St extends CoreAppStore> extends ChangeNotifier {
  final BuildContext _context;

  bool isDisposed = false;

  Vm({required BuildContext context}) : _context = context;

  St get appStore => _context.readAppStore<St>();

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    log("Called dispose() for $runtimeType VM");
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
