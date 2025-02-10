import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myspace_core/myspace_core.dart';

abstract class StateStatusProvider<St>
    extends BaseStateProvider<St, ReduxStateStatus> {
  const StateStatusProvider({super.key});

  @override
  ReduxStateStatus selector(St state);

  Widget loadedBuilder(BuildContext context, ReduxStateLoaded vm);

  Widget errorBuilder(BuildContext context, ReduxStateError vm);

  Widget? initialBuilder(BuildContext context, StateInitial vm) => null;

  Widget? customBuilder(BuildContext context, ReduxStateStatus vm) => null;

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    final sc = StoreConnector<St, ReduxStateStatus>(
      distinct: true,
      converter: (store) => selector(store.state),
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      onDidChange: onDidChange,
      builder: (context, vm) {
        log("Rebuild ${key ?? "state_status_provider"}, hashCode ${vm.hashCode}");

        final custom = customBuilder.call(context, vm);
        if (custom != null) return custom;

        switch (vm) {
          case ReduxStateLoading():
            return const CircularProgressIndicator();
          case ReduxStateLoaded():
            return loadedBuilder.call(context, vm);
          case ReduxStateError():
            return errorBuilder.call(context, vm);
          case StateInitial():
            return const SizedBox.shrink();
        }
      },
    );

    return wrapper(sc) ?? sc;
  }
}
