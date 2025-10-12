import 'dart:developer';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    log('Building SplashPage');

    return Scaffold(
      body: VmSelector<SplashPageVm, int>(
        selector: (context, vm) => vm.state.counter2,
        builder: (context, counter2, _) {
          log('Building SplashPage with counter2: $counter2');
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
                      onPressed: () async {
                        final event = RandomNumberEvent();
                        vm.addEvent(event);
                        final result = await event.completer.future;
                        print(result);
                      },
                      child: Text(vm.state.counter.toString()),
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
                      onPressed: () => context.push('/third'),
                      child: Text('Go to Third Page'),
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
                      onPressed: () =>
                          ErrorDialog.show('Something went wrong!'),
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
                      onPressed: () => InfoDialog.show(info: 'Archive only!'),
                      child: Text('Show Info'),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    // print('build show success button');
                    return TextButton(
                      onPressed: () async {
                        await SuccessDialog.show('Deleted correctly!');
                        print('Success');
                      },
                      child: Text('Show Success'),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    // print('build show prompt button');
                    return TextButton(
                      onPressed: () async {
                        final result = await PromptDialog.show(
                          'Do you want to delete?',
                          dismissable: true,
                          onRightClick: (close) async {
                            await Future.delayed(Duration(seconds: 1));
                            close();
                          },
                        );

                        print('Prompt result: $result');
                      },
                      child: Text('Show Prompt'),
                    );
                  },
                ),
                const SizedBox(height: 20),

                VmWatcher<SplashPageVm>(
                  builder: (context, vm, child) {
                    return Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Counter 1: ${vm.state.counter}'),
                        Text('Counter 2: ${vm.state.counter2}'),
                        TextButton(
                          onPressed: () async {
                            // vm.addEvent(IncrementCounterEvent(0));
                            // vm.addEvent(DecrementCounterEvent(0));
                            // vm.addEvent(IncrementCounterEvent(0));
                            // vm.addEvent(DecrementCounterEvent(0));
                            // await Future.wait([
                            //   vm.addEvent(IncrementCounterEvent(0)),
                            //   vm.addEvent(DecrementCounterEvent(0)),
                            //   vm.addEvent(IncrementCounterEvent(0)),
                            //   vm.addEvent(DecrementCounterEvent(0)),
                            // ]);
                            // vm.addEvents([
                            //   IncrementCounterEvent(0),
                            //   DecrementCounterEvent(0),
                            //   // IncrementCounterEvent(0),
                            //   // DecrementCounterEvent(0),
                            // ]);
                            vm.addEvent(IncrementCounterEvent(0));
                          },
                          child: Text('Increment'),
                        ),
                        TextButton(
                          onPressed: () async {
                            vm.addEvent(DecrementCounterEvent(0));
                          },
                          child: Text('Decrement'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
