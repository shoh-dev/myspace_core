import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:provider/provider.dart';

Future<void> runMySpaceApp<St extends CoreAppStore>(
    CoreAppConfig<St> config) async {
  final router = config.root.toRouter();
  final appStore = config.appStore;
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider.value(value: appStore)],
        child: UIApp(routerConfig: router)),
  );
}

class CoreAppConfig<St extends CoreAppStore> {
  final UIRoot root;
  final St appStore;

  CoreAppConfig({
    required this.root,
    required this.appStore,
  });
}
