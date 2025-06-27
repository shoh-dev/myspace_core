import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';

class CommandWrapper<T> extends StatelessWidget {
  final Command<T> command;

  const CommandWrapper({
    super.key,
    required this.command,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, Command<T> command, Widget? child)
  builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (context, child) => builder(context, command, child),
      child: child,
    );
  }
}
