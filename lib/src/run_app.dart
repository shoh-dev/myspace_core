import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';
import 'package:myspace_core/src/data/dependency.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:provider/provider.dart';

Future<void> runMySpaceApp<St extends CoreAppStore>(
    CoreAppConfig<St> config) async {
  final appStore = config.appStore;
  final dependencies = config.dependencies;
  final root = config.root(appStore);
  final theme = config.theme;
  final router = root.toRouter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<St>.value(value: appStore),
        for (final dep in dependencies) dep,
      ],
      child: UIApp(
        routerConfig: router,
        lightTheme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        themeMode: theme.themeMode,
      ),
    ),
  );
}

class CoreAppConfig<St extends CoreAppStore> {
  final St appStore;
  final UIRoot Function(St store) root;
  final List<InheritedProvider<Dependency>> dependencies;
  final UITheme<St> theme;

  CoreAppConfig({
    required this.root,
    required this.appStore,
    this.dependencies = const [],
    this.theme = const UITheme(),
  });
}

class UITheme<St extends CoreAppStore> {
  final ThemeData Function(BuildContext context)? lightTheme;
  final ThemeData Function(BuildContext context)? darkTheme;
  final ThemeMode Function(BuildContext context)? themeMode;

  const UITheme({
    this.lightTheme,
    this.darkTheme,
    this.themeMode,
  });
}
