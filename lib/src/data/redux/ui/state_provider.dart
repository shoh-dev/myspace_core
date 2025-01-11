import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myspace_core/myspace_core.dart';

typedef Selector<St, Vm> = Vm Function(St state);
typedef ErrorBuilder<Vm> = Widget Function(
    BuildContext context, ResultError<Vm> vm);
typedef OkBuilder<Vm> = Widget Function(BuildContext context, ResultOk<Vm> vm);
typedef CustomBuilder<Vm> = Widget Function(
    BuildContext context, Result<Vm> vm);
typedef NormalBuilder<Vm> = Widget Function(
    BuildContext context, Vm vm, VoidCallback? retryAction);

class ResultStateProvider<St, Vm> extends StatelessWidget {
  const ResultStateProvider({
    super.key,
    required this.selector,
    this.errorBuilder,
    this.okBuilder,
    this.customBuilder,
    this.retryAction,
    this.onInitialBuild,
    this.onDispose,
    this.onDidChange,
  });

  final VoidCallback? retryAction;

  ///[errorBuilder] is called when the view model is a [ResultFailure<Vm>]
  ///
  ///default implementation returns null which results to [Center(child: Text(vm.failMessage))]
  final ErrorBuilder<Vm>? errorBuilder;

  ///[okBuilder] is called when the view model is a [ResultData<Vm>]
  ///
  ///default implementation returns null which results to [nil]
  final OkBuilder<Vm>? okBuilder;

  ///[customBuilder] is called when the view model is a [Result<Vm>]
  ///
  ///can make custom builders for each state manually
  final CustomBuilder<Vm>? customBuilder;

  ///[onInit] is called when the widget is built for the first time
  // void onInit(Result<Vm> vm) {}

  ///[onDispose] is called when the widget is disposed
  // void onDispose(Store<St> store) {}

  ///[selector] is a function that takes the current state and returns the view model as a [Result<Vm>]
  final Selector<St, Result<Vm>> selector;

  final OnInitialBuildCallback<Result<Vm>>? onInitialBuild;

  final OnDisposeCallback<St>? onDispose;

  final OnDidChangeCallback<Result<Vm>>? onDidChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<St, Result<Vm>>(
      distinct: true,
      converter: (store) => selector(store.state),
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      onDidChange: onDidChange,
      builder: (context, vm) {
        log("Rebuild $key, hashCode ${vm.hashCode}");

        //Custom builder
        final custom = customBuilder?.call(context, vm);
        if (custom != null) return custom;

        //Error builder
        if (vm is ResultError) {
          final error = errorBuilder?.call(context, vm as ResultError<Vm>);
          if (error != null) return error;
          return Center(
              child: Text((vm as ResultError)
                  .error
                  .toString())); //todo: change to ErrorIndicator
          // return ErrorIndicator(
          // title: "Error loading",
          // label: (vm as ResultError).error.toString(),
          // onPressed: retryAction,
          // );
        }

        //Ok builder
        final ok = okBuilder?.call(context, vm as ResultOk<Vm>);
        if (ok != null) return ok;

        assert(ok != null || custom != null,
            "You must provide either an [okBuilder] or a [customBuilder]");

        return const SizedBox();
      },
    );
  }
}

class StateProvider<St, Vm> extends StatelessWidget {
  const StateProvider({
    super.key,
    required this.selector,
    required this.builder,
    this.retryAction,
    this.onInitialBuild,
    this.onDispose,
    this.onDidChange,
  });

  final VoidCallback? retryAction;

  ///[okBuilder] is called when the view model is a [ResultData<Vm>]
  ///
  ///default implementation returns null which results to [nil]
  final NormalBuilder<Vm> builder;

  ///[selector] is a function that takes the current state and returns the view model as a [Result<Vm>]
  final Selector<St, Vm> selector;

  final OnInitialBuildCallback<Vm>? onInitialBuild;

  final OnDisposeCallback<St>? onDispose;

  final OnDidChangeCallback<Vm>? onDidChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<St, Vm>(
      distinct: true,
      converter: (store) => selector(store.state),
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      onDidChange: onDidChange,
      builder: (context, vm) {
        log("Rebuild $key, hashCode ${vm.hashCode}");

        return builder(context, vm, retryAction);
      },
    );
  }
}
