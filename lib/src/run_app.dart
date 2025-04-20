import 'dart:async';

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
  final builder = config.builder;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<St>.value(value: appStore),
        for (final dep in dependencies) dep,
      ],
      child: UIApp(
        routerConfig: router,
        theme: theme.theme,
        themeMode: theme.themeMode,
        builder: builder,
      ),
    ),
  );
}

class CoreAppConfig<St extends CoreAppStore> {
  final St appStore;
  final UIRoot Function(St store) root;
  final List<InheritedProvider<Dependency>> dependencies;
  final UITheme theme;
  final TransitionBuilder? builder;

  CoreAppConfig({
    required this.root,
    required this.appStore,
    this.dependencies = const [],
    this.theme = const UITheme(),
    this.builder,
  });
}

class UITheme {
  final AppTheme Function(BuildContext context)? theme;
  final ThemeMode Function(BuildContext context)? themeMode;

  const UITheme({
    this.theme,
    this.themeMode,
  });
}
