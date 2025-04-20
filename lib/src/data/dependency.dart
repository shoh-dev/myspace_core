import 'package:flutter/material.dart';

abstract class Dependency {
  const Dependency();
}

abstract class DependencyChangeNotifier extends ChangeNotifier
    implements Dependency {}
