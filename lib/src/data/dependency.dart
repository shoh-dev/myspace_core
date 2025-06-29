import 'package:flutter/material.dart';

abstract class Dependency {
  const Dependency();

  void dispose() {
    // Optionally override this method to clean up resources
    print('Disposing dependency: $runtimeType');
  }
}

abstract class DependencyChangeNotifier extends ChangeNotifier
    implements Dependency {}
