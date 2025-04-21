import 'package:example/features/first/first_layout_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FirstPage extends StatelessWidget {
  static final page = UIPage(
    name: 'first',
    path: "/first",
    builder: (context, state) => const FirstPage(),
  );

  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          VmWatcher<FirstLayoutVm>(
            builder: (context, vm, child) {
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
