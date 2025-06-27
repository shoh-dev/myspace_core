import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

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
