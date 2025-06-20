import 'dart:developer';

import 'package:example/core/store.dart';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    log('Building SplashPage');

    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              // GoRouter.of(context).refresh();
            },
            child: Text("Refresh page"),
          ),
          VmWatcher<SplashPageVm>(
            builder: (context, vm, child) {
              return TextButton(
                onPressed: () {
                  vm.incrementCounter1();
                },
                child: Text(vm.counter1.toString()),
              );
            },
          ),

          // VmProvider(
          //   vm: widget.vm,
          //   builder: (context) {
          //     return TextButton(
          //       onPressed: () {
          //         widget.vm.incrementCounter1();
          //       },
          //       child: Text(widget.vm.storeCounter.toString()),
          //     );
          //   },
          // ),
          AppStoreWatcher<AppStore>(
            builder: (context, store, _) {
              // print('build store counter');
              return TextButton(
                onPressed: store.increment,
                child: Text("Store: ${store.counter}"),
              );
            },
          ),

          Builder(
            builder: (context) {
              // print('build go to homepage button');
              return TextButton(
                onPressed: () => context.go('/home'),
                child: Text('Go to Homepage'),
              );
            },
          ),

          Builder(
            builder: (context) {
              // print('build go to homepage button');
              return TextButton(
                onPressed: () => context.go('/page1'),
                child: Text('Go to First Page'),
              );
            },
          ),

          Builder(
            builder: (context) {
              // print('build show error button');
              return TextButton(
                onPressed: () => ErrorDialog.show('Something went wrong!'),
                // onPressed:
                //     () => showDialog(
                //       context: context,
                //       builder: (context) {
                //         return ErrorDialog(
                //           content: 'Something went wrong!',
                //           onClose: () {
                //             Navigator.pop(context);
                //           },
                //         );
                //       },
                //     ),
                child: Text('Show Error'),
              );
            },
          ),

          Builder(
            builder: (context) {
              // print('build show loading button');
              return TextButton(
                onPressed: () {
                  final cancel = LoadingDialog.show();
                  Future.delayed(Duration(seconds: 3), cancel);
                },
                child: Text('Show Loading'),
              );
            },
          ),
          Builder(
            builder: (context) {
              // print('build show info button');
              return TextButton(
                onPressed: () => InfoDialog.show('Archive only!'),
                child: Text('Show Info'),
              );
            },
          ),
          Builder(
            builder: (context) {
              // print('build show success button');
              return TextButton(
                onPressed: () => SuccessDialog.show('Deleted correctly!'),
                child: Text('Show Success'),
              );
            },
          ),
          Builder(
            builder: (context) {
              // print('build show prompt button');
              return TextButton(
                onPressed: () {
                  PromptDialog.show(
                    'Do you want to delete?',
                    onLeftClick: (close) {
                      close();
                    },
                    onRightClick: (close) {
                      close();
                    },
                  );
                },
                // () {
                //   showDialog(
                //     context: context,
                //     builder: (context) {
                //       return PromptDialog(
                //         content: 'Do you want to delete?',
                //         onLeftClick: () {},
                //         onRightClick: () {},
                //       );
                //     },
                //   );
                // },
                child: Text('Show Prompt'),
              );
            },
          ),
        ],
      ),
    );
  }
}
