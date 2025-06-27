import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:provider/provider.dart';

class DependencySelector<FROMDEP extends Dependency, TOVALUE>
    extends StatelessWidget {
  const DependencySelector({
    super.key,
    required this.builder,
    required this.selector,
    this.child,
  });

  final Widget? child;
  final TOVALUE Function(BuildContext context, FROMDEP dep) selector;
  final ValueWidgetBuilder<TOVALUE> builder;

  @override
  Widget build(BuildContext context) {
    return Selector<FROMDEP, TOVALUE>(
      selector: selector,
      builder: builder,
      child: child,
    );
  }
}

class DependencyWatcher<DEP extends DependencyChangeNotifier>
    extends StatelessWidget {
  const DependencyWatcher({super.key, required this.builder, this.child});

  final Widget? child;
  final Widget Function(BuildContext context, DEP dep, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<DEP>(builder: builder, child: child);
  }
}
