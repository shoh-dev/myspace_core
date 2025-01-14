import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

export 'result_state_provider.dart';

abstract class BaseStateProvider<St, Vm> extends StatelessWidget {
  const BaseStateProvider({super.key});

  ///[onInitialBuild] is called when the widget is built for the first time
  FutureOr<void> onInitialBuild(Vm vm) {}

  ///[onDispose] is called when the widget is disposed
  FutureOr<void> onDispose(Store<St> store) {}

  ///[onDidChange] is called when the [viewModel] changes
  FutureOr<void> onDidChange(Vm? previousViewModel, Vm viewModel) {}

  ///[selector] is called to get the viewModel from the state
  Vm selector(St state);
}

// abstract class BaseStatefulProvider<St, Vm> extends StatefulWidget {
//   const BaseStatefulProvider({super.key});

//   ///[onInitialBuild] is called when the widget is built for the first time
//   FutureOr<void> onInitialBuild(Vm vm) {}

//   ///[onDispose] is called when the widget is disposed
//   FutureOr<void> onDispose(Store<St> store) {}

//   ///[onDidChange] is called when the [viewModel] changes
//   FutureOr<void> onDidChange(Vm? previousViewModel, Vm viewModel) {}

//   ///[selector] is called to get the viewModel from the state
//   Vm selector(St state);
// }

// abstract class BaseStatefulProviderState<W extends BaseStatefulProvider>
//     extends State<W> {
//   @override
//   Widget build(BuildContext context);
// }

abstract class StateProvider<St, Vm> extends BaseStateProvider<St, Vm> {
  const StateProvider({super.key});

  Widget builder(BuildContext context, Vm vm);

  @nonVirtual
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
        return builder(context, vm);
      },
    );
  }
}
