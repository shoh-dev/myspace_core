import 'package:example/core/store.dart';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

class SplashPage extends StatelessWidget {
  const SplashPage(this.vm, {super.key});

  final SplashPageVm vm;

  @override
  Widget build(BuildContext context) {
    print('build SplashPage');

    return Center(
      child: Column(
        children: [
          VmProvider(
            vm: vm,
            builder: (context) {
              print('build counter1');
              return TextButton(
                onPressed: vm.incrementCounter1,
                child: Text(vm.counter1.toString()),
              );
            },
          ),

          AppStoreProvider<AppStore>(
            builder: (context, store) {
              print('build store counter');
              return TextButton(
                onPressed: store.increment,
                child: Text(store.counter.toString()),
              );
            },
          ),

          Builder(
            builder: (context) {
              print('build go to homepage button');
              return TextButton(
                onPressed: () => context.goNamed('homepage'),
                child: Text('Go to Homepage'),
              );
            },
          ),
        ],
      ),
    );
  }
}
