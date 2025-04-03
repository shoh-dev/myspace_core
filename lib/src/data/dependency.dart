import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension DependencyBuildContextHelper on BuildContext {
  Dp readDependency<Dp extends Dependency>() => read<Dp>();
  Dp watchDependency<Dp extends Dependency>() => watch<Dp>();
}

abstract class Dependency {
  const Dependency();
}

abstract class DependencyListener extends ChangeNotifier
    implements Dependency {}
