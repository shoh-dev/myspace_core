import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Dependency {
  const Dependency();
}

extension DependencyBuildContextHelper on BuildContext {
  Dp readDependency<Dp extends Dependency>() => read<Dp>();
}
