import 'package:flutter/material.dart';

abstract class Dependency {
  const Dependency();

  void dispose() {
    // Optionally override this method to clean up resources
    debugPrint('Disposing dependency: $runtimeType');
  }
}

abstract class DependencyChangeNotifier extends ChangeNotifier
    implements Dependency {}

mixin DependencyMixin on Dependency {}
