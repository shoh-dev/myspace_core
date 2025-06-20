import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:provider/provider.dart';

abstract class Vm extends ChangeNotifier {
  bool isDisposed = false;

  late final log = Logger(runtimeType.toString());

  Vm();

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    dev.log("dispose() for $runtimeType VM");
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
    dev.log("notifyListeners() for $runtimeType VM");
  }
}

class VmReader<VM extends Vm> extends StatelessWidget {
  const VmReader({super.key, required this.builder});

  final Widget Function(BuildContext context, VM vm) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.read<VM>());
  }
}

class VmWatcher<VM extends Vm> extends StatelessWidget {
  const VmWatcher({super.key, required this.builder, this.child});

  final Widget? child;
  final Widget Function(BuildContext context, VM vm, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<VM>(builder: builder, child: child);
  }
}

class VmSelector<FROMVM extends Vm, TOVALUE> extends StatelessWidget {
  const VmSelector({
    super.key,
    required this.builder,
    required this.selector,
    this.child,
  });

  final Widget? child;
  final TOVALUE Function(BuildContext context, FROMVM vm) selector;
  final ValueWidgetBuilder<TOVALUE> builder;

  @override
  Widget build(BuildContext context) {
    return Selector<FROMVM, TOVALUE>(
      shouldRebuild: (previous, next) => previous != next,
      selector: selector,
      builder: builder,
      child: child,
    );
  }
}

class DependencySelector<FROMDEP extends Dependency, TOVALUE>
    extends StatelessWidget {
  const DependencySelector({
    super.key,
    required this.builder,
    required this.selector,
    this.child,
  });

  final Widget? child;
  final TOVALUE Function(BuildContext context, FROMDEP dep) selector;
  final ValueWidgetBuilder<TOVALUE> builder;

  @override
  Widget build(BuildContext context) {
    return Selector<FROMDEP, TOVALUE>(
      selector: selector,
      builder: builder,
      child: child,
    );
  }
}

class DependencyWatcher<DEP extends DependencyChangeNotifier>
    extends StatelessWidget {
  const DependencyWatcher({super.key, required this.builder, this.child});

  final Widget? child;
  final Widget Function(BuildContext context, DEP dep, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<DEP>(builder: builder, child: child);
  }
}

class AppStoreWatcher<St extends CoreAppStore> extends StatelessWidget {
  const AppStoreWatcher({super.key, required this.builder, this.child});

  final Widget Function(BuildContext context, St store, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    dev.log('AppStoreProvider build');
    return Consumer<St>(builder: builder, child: child);
  }
}

class AppStoreSelector<APPSTORE extends CoreAppStore, TOVALUE>
    extends StatelessWidget {
  const AppStoreSelector({
    super.key,
    required this.builder,
    required this.selector,
    this.child,
  });

  final Widget? child;
  final TOVALUE Function(BuildContext context, APPSTORE appStore) selector;
  final ValueWidgetBuilder<TOVALUE> builder;

  @override
  Widget build(BuildContext context) {
    return Selector<APPSTORE, TOVALUE>(
      selector: selector,
      builder: builder,
      child: child,
    );
  }
}

class CommandWrapper<T> extends StatelessWidget {
  final Command<T> command;

  const CommandWrapper({
    super.key,
    required this.command,
    required this.builder,
    this.child,
    this.onRetry,
  });

  final Widget Function(BuildContext context, Command<T> command, Widget? child)
  builder;

  final Widget? child;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (context, child) => builder(context, command, child),
      child: child,
      // builder: (context, child) {
      //   if (command.isRunning) {
      //     return const Center(child: CircularProgressIndicator.adaptive());
      //   }

      //   final result = command.result ?? const ResultOk<void>(null);

      //   switch (result) {
      //     case ResultOk<void>():
      //       return okBuilder(context, child);
      //     case ResultError<void>():
      //       if (errorBuilder != null) {
      //         return errorBuilder!(context, result, child);
      //       }
      //       final retry =
      //           command is CommandNoParam
      //               ? (command as CommandNoParam).execute
      //               : null;
      //       return ErrorDialog(
      //         content: result.e.toString(),
      //         actionText: retry != null ? 'Retry' : null,
      //         actionCallback: retry,
      //       );
      //   }
      // },
    );
  }
}
