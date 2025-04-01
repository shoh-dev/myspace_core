import 'package:example/core/store.dart';
import 'package:example/features/home/home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.vm, {super.key});

  final HomePageVm vm;

  @override
  Widget build(BuildContext context) {
    print('Building HomePage');
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Center(
          child: Column(
            children: [
              AppStoreProvider<AppStore>(
                builder: (context, store) {
                  print('build store counter');
                  return TextButton(
                    onPressed: store.increment,
                    child: Text(store.counter.toString()),
                  );
                },
              ),
              TextButton(
                onPressed: () => context.goNamed('splash'),
                child: Text('Go to Splash'),
              ),
            ],
          ),
        );
      },
    );
  }
}
