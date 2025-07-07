import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/src/routing/route.dart';
import 'package:myspace_core/src/routing/transitions.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class UIRoot {
  final List<UIRoute> layouts;
  final GoRouterRedirect? redirect;
  final Listenable? refreshListenable;
  final String? initialLocation;
  final TransitionType? defaultTransition;
  final Widget Function(BuildContext context, GoRouterState state)?
  errorBuilder;

  const UIRoot({
    required this.layouts,
    this.redirect,
    this.defaultTransition,
    this.refreshListenable,
    this.initialLocation,
    this.errorBuilder,
  });

  GoRouter toRouter() {
    log('Running toRouter()');
    return GoRouter(
      navigatorKey: _navigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: initialLocation,
      redirect: redirect,
      refreshListenable: refreshListenable,
      errorBuilder: errorBuilder,
      observers: [BotToastNavigatorObserver()],
      routes: [
        for (final layout in layouts)
          layout.build(
            defaultTransition: defaultTransition ?? TransitionType.material,
          ),
      ],
    );
  }
}
