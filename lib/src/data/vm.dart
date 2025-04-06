import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:provider/provider.dart';

abstract class Vm extends ChangeNotifier {
  bool isDisposed = false;

  late final log = Logger(runtimeType.toString());

  Vm();

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    log.info("Called dispose() for $runtimeType VM");
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
    dev.log('AppStoreProvider build');
    return Consumer<St>(
      builder: builder,
      child: child,
    );
  }
}

class CommandWrapper extends StatelessWidget {
  final Command command;

  const CommandWrapper({
    super.key,
    required this.command,
    required this.okBuilder,
    this.errorBuilder,
    this.child,
  });

  final Widget Function(BuildContext context, Widget? child) okBuilder;
  final Widget Function(BuildContext context, ResultError error, Widget? child)?
      errorBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: command,
        child: child,
        builder: (context, child) {
          if (command.isRunning) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final result = command.result!;

          switch (result) {
            case ResultOk<void>():
              return okBuilder(context, child);
            case ResultError<void>():
              if (errorBuilder != null) {
                return errorBuilder!(context, result, child);
              }
              final retry = command is CommandNoParam
                  ? (command as CommandNoParam).execute
                  : null;
              return ErrorDialog(
                content: result.e.toString(),
                actionText: retry != null ? 'Retry' : null,
                actionCallback: retry,
              );
          }
        });
  }
}
