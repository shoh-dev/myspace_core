import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myspace_core/myspace_core.dart';

abstract class ResultStateProvider<St, Vm>
    extends BaseStateProvider<St, Result<Vm>> {
  const ResultStateProvider({super.key});

  Widget? errorBuilder(BuildContext context, ResultError<Vm> vm) => null;

  Widget? okBuilder(BuildContext context, ResultOk<Vm> vm) => null;

  Widget? customBuilder(BuildContext context, Result<Vm> vm) => null;

  @override
  Result<Vm> selector(St state);

  @nonVirtual
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
        final custom = customBuilder.call(context, vm);
        if (custom != null) return custom;

        //Error builder
        if (vm is ResultError) {
          final error = errorBuilder.call(context, vm as ResultError<Vm>);
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
        final ok = okBuilder.call(context, vm as ResultOk<Vm>);
        if (ok != null) return ok;

        assert(ok != null || custom != null,
            "You must provide either an [okBuilder] or a [customBuilder]");

        return const SizedBox();
      },
    );
  }
}
