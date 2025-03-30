import 'package:example/features/splash/splash_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage(this.vm, {super.key});

  final SplashPageVm vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Center(
          child: Column(
            children: [
              TextButton(
                onPressed: vm.appStore.increment,
                child: Text(vm.appStore.counter.toString()),
              ),
              TextButton(
                onPressed: () => context.replaceNamed('homepage'),
                child: Text('Go to Homepage'),
              ),
            ],
          ),
        );
      },
    );
  }
}
