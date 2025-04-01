import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';
import 'package:myspace_core/src/data/dependency.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:provider/provider.dart';

Future<void> runMySpaceApp<St extends CoreAppStore>(
    CoreAppConfig<St> config) async {
  final appStore = config.appStore;
  final dependencies = config.dependencies;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<St>.value(value: appStore),
        for (final dep in dependencies) dep,
      ],
      child: UIApp(routerConfig: config.root(appStore).toRouter()),
    ),
  );
}

class CoreAppConfig<St extends CoreAppStore> {
  final St appStore;
  final UIRoot Function(St store) root;
  final List<InheritedProvider<Dependency>> dependencies;

  CoreAppConfig({
    required this.root,
    required this.appStore,
    this.dependencies = const [],
  });
}
