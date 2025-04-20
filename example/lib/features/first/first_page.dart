import 'package:example/features/first/first_layout_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FirstPage extends StatelessWidget {
  static final page = UIPage(
    name: 'first',
    path: "/first",
    builder: (context, state) {
      return FirstPage(context.read());
    },
  );

  const FirstPage(this.vm, {super.key});

  final FirstLayoutVm vm;

  @override
  Widget build(BuildContext context) {
    print('Building FirstPage');

    return Center(
      child: Column(
        children: [
          VmProvider2<FirstLayoutVm>(
            builder: (context, _, vm) {
              print(vm.counter);
              return TextButton(
                onPressed: vm.incrementCounter,
                child: Text(vm.counter.toString()),
              );
            },
          ),
          TextButton(
            onPressed: () => context.goNamed("splash"),
            child: Text("Go To Splash"),
          ),
        ],
      ),
    );
  }
}
