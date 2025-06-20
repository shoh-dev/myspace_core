import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef TransitionBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    );

enum TransitionType {
  slideFromRight,
  slideFromLeft,
  slideFromTop,
  slideFromBottom,
  scale,
  fade,
  cupertino,
  material;

  Widget builder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (this) {
      case TransitionType.fade:
        return FadeTransition(opacity: animation, child: child);
      case TransitionType.slideFromRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: _elevation(child),
        );
      case TransitionType.slideFromLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: _elevation(child),
        );
      case TransitionType.slideFromTop:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: _elevation(child),
        );
      case TransitionType.slideFromBottom:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: _elevation(child),
        );
      case TransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1).animate(animation),
          child: _elevation(child),
        );
      case TransitionType.cupertino:
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: true,
          child: child,
        );
      case TransitionType.material:
        return child;
    }
  }

  Widget _elevation(Widget child) {
    return PhysicalModel(color: Colors.transparent, elevation: 2, child: child);
  }
}
