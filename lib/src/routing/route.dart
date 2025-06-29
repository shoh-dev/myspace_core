import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/src/data/vm.dart';
import 'package:myspace_core/src/routing/transitions.dart';
import 'package:provider/provider.dart';

typedef RouteVm<VM extends Vm> =
    VM Function(BuildContext context, GoRouterState state);

sealed class UIRoute<VM extends Vm> {
  const UIRoute();

  RouteBase build({required TransitionType defaultTransition}) {
    return switch (this) {
      UILayout layout => layout.toShellRoute(
        defaultTransition: defaultTransition,
      ),
      UIPage page => page.toGoRoute(defaultTransition: defaultTransition),
      UIDialog dialog => dialog.toGoRoute(defaultTransition: defaultTransition),
    };
  }

  //Factories

  factory UIRoute.layout({
    required StatefulShellRouteBuilder? layoutBuilder,
    GoRouterRedirect? redirect,
    required List<UIBranch> branches,
    RouteVm<VM>? vm,
  }) => UILayout(
    layoutBuilder: layoutBuilder,
    redirect: redirect,
    branches: branches,
    vm: vm,
  );

  factory UIRoute.page({
    String? name,
    required String path,
    GoRouterRedirect? redirect,
    List<UIRoute> pages = const [],
    GoRouterWidgetBuilder? builder,
    TransitionType? transitionType,
    Duration? transitionDuration,
    RouteVm<VM>? vm,
  }) => UIPage(
    path: path,
    pages: pages,
    name: name,
    redirect: redirect,
    builder: builder,
    transitionType: transitionType,
    transitionDuration: transitionDuration,
    vm: vm,
  );

  factory UIRoute.dialog({
    String? name,
    required String path,
    GoRouterRedirect? redirect,
    List<UIRoute> pages = const [],
    GoRouterWidgetBuilder? builder,
    RouteVm<VM>? vm,
  }) => UIDialog(
    name: name,
    path: path,
    redirect: redirect,
    pages: pages,
    builder: builder,
    vm: vm,
  );
}

class UILayout<VM extends Vm> extends UIRoute<VM> {
  final StatefulShellRouteBuilder? layoutBuilder;
  final GoRouterRedirect? redirect;
  final List<UIBranch> branches;
  final RouteVm<VM>? vm;
  final TransitionType? transitionType;
  final Duration? transitionDuration;

  const UILayout({
    this.layoutBuilder,
    required this.branches,
    this.redirect,
    this.vm,
    this.transitionType,
    this.transitionDuration,
  });

  StatefulShellRoute toShellRoute({required TransitionType defaultTransition}) {
    return StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        final transition = transitionType ?? defaultTransition;
        Widget child = layoutBuilder!(context, state, navigationShell);
        if (vm != null) {
          child = ChangeNotifierProvider(
            create: (context) {
              log('Registering vm: $VM');
              return vm!(context, state);
            },
            builder: (context, _) =>
                layoutBuilder!(context, state, navigationShell),
          );
        }
        switch (transition) {
          case TransitionType.material:
            return MaterialPage(key: state.pageKey, child: child);
          case TransitionType.cupertino:
            return CupertinoPage(key: state.pageKey, child: child);
          default:
            return CustomTransitionPage(
              reverseTransitionDuration:
                  transitionDuration ?? const Duration(milliseconds: 300),
              transitionDuration:
                  transitionDuration ?? const Duration(milliseconds: 300),
              key: state.pageKey,
              child: child,
              transitionsBuilder: transition.builder,
            );
        }
      },
      redirect: redirect,
      branches: [
        for (final branch in branches)
          branch.toStatefulShellBranch(defaultTransition: defaultTransition),
      ],
    );
  }
}

class UIBranch {
  final List<UIRoute> pages;
  final String? initialLocation;

  const UIBranch({required this.pages, this.initialLocation});

  StatefulShellBranch toStatefulShellBranch({
    required TransitionType defaultTransition,
  }) {
    return StatefulShellBranch(
      initialLocation: initialLocation,
      routes: [
        for (final page in pages)
          page.build(defaultTransition: defaultTransition),
      ],
    );
  }
}

class UIPage<VM extends Vm> extends UIRoute<VM> {
  const UIPage({
    this.name,
    this.transitionType,
    required this.path,
    this.builder,
    this.redirect,
    this.pages = const [],
    this.transitionDuration,
    this.vm,
  });

  final String? name;
  final String path;
  final GoRouterRedirect? redirect;
  final List<UIRoute> pages;
  final GoRouterWidgetBuilder? builder;
  final TransitionType? transitionType;
  final Duration? transitionDuration;
  final RouteVm<VM>? vm;

  GoRoute toGoRoute({required TransitionType defaultTransition}) {
    final transition = transitionType ?? defaultTransition;
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [
        for (final subPage in pages)
          subPage.build(defaultTransition: defaultTransition),
      ],
      pageBuilder: builder != null
          ? (context, state) {
              Widget child = builder!(context, state);

              if (vm != null) {
                child = ChangeNotifierProvider(
                  create: (context) {
                    log('Registering vm: $VM');
                    return vm!(context, state);
                  },
                  builder: (context, _) => builder!(context, state),
                );
              }

              switch (transition) {
                case TransitionType.material:
                  return MaterialPage(key: state.pageKey, child: child);
                case TransitionType.cupertino:
                  return CupertinoPage(key: state.pageKey, child: child);
                default:
                  return CustomTransitionPage(
                    reverseTransitionDuration:
                        transitionDuration ?? const Duration(milliseconds: 300),
                    transitionDuration:
                        transitionDuration ?? const Duration(milliseconds: 300),
                    key: state.pageKey,
                    child: child,
                    transitionsBuilder: transition.builder,
                  );
              }
            }
          : null,
      // builder: builder,
    );
  }
}

class UIDialog<VM extends Vm> extends UIRoute<VM> {
  const UIDialog({
    this.name,
    required this.path,
    this.builder,
    this.redirect,
    this.pages = const [],
    this.vm,
  });

  final String? name;
  final String path;
  final GoRouterRedirect? redirect;
  final List<UIRoute> pages;
  final GoRouterWidgetBuilder? builder;
  final RouteVm<VM>? vm;

  GoRoute toGoRoute({required TransitionType defaultTransition}) {
    return GoRoute(
      path: path,
      name: name,
      redirect: redirect,
      routes: [
        for (final subPage in pages)
          subPage.build(defaultTransition: defaultTransition),
      ],
      pageBuilder: builder != null
          ? (context, state) {
              Widget child = builder!(context, state);

              if (vm != null) {
                child = ChangeNotifierProvider(
                  create: (context) {
                    log('Registering vm: $VM');
                    return vm!(context, state);
                  },
                  builder: (context, _) => builder!(context, state),
                );
              }

              return _DialogPage(
                name: name,
                key: state.pageKey,
                builder: (context) => child,
              );
            }
          : null,
      // builder: builder,
    );
  }
}

//  pageBuilder:
//           builder != null
//               ? (context, state) {
//                 return _DialogPage(
//                   name: name,
//                   key: state.pageKey,
//                   builder: (context) => builder!(context, state),
//                 );
//               }
//               : null,

//https://croxx5f.hashnode.dev/adding-modal-routes-to-your-gorouter
class _DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const _DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder: builder,
    anchorPoint: anchorPoint,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    themes: themes,
  );
}
