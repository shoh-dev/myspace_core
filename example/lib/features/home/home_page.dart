import 'package:example/features/home/home_page_vm.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.vm, {super.key});

  final HomePageVm vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Center(
          child: TextButton(
            onPressed: vm.appStore.increment,
            child: Text(vm.appStore.counter.toString()),
          ),
        );
      },
    );
  }
}
