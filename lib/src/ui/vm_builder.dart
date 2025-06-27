import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:provider/provider.dart';

class VmReader<VM extends Vm> extends StatelessWidget {
  const VmReader({super.key, required this.builder});

  final Widget Function(BuildContext context, VM vm) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.read<VM>());
  }
}

class VmWatcher<VM extends Vm> extends StatelessWidget {
  const VmWatcher({super.key, required this.builder, this.child});

  final Widget? child;
  final Widget Function(BuildContext context, VM vm, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<VM>(builder: builder, child: child);
  }
}

class VmSelector<FROMVM extends Vm, TOVALUE> extends StatelessWidget {
  const VmSelector({
    super.key,
    required this.builder,
    required this.selector,
    this.child,
  });

  final Widget? child;
  final TOVALUE Function(BuildContext context, FROMVM vm) selector;
  final ValueWidgetBuilder<TOVALUE> builder;

  @override
  Widget build(BuildContext context) {
    return Selector<FROMVM, TOVALUE>(
      shouldRebuild: (previous, next) => previous != next,
      selector: selector,
      builder: builder,
      child: child,
    );
  }
}
