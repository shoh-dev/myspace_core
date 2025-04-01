import 'package:example/core/store.dart';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage(this.vm, {super.key});

  final SplashPageVm vm;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void dispose() {
    // log('Dispose SplashPage');
    widget.vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building SplashPage');

    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).refresh();
            },
            child: Text("Refresh page"),
          ),
          VmProvider(
            vm: widget.vm,
            builder: (context) {
              return TextButton(
                onPressed: () {
                  widget.vm.incrementCounter1();
                },
                child: Text(widget.vm.counter1.toString()),
              );
            },
          ),

          AppStoreProvider<AppStore>(
            builder: (context, store) {
              print('build store counter');
              return TextButton(
                onPressed: store.increment,
                child: Text("Store: ${widget.vm.appStore.counter}"),
              );
            },
          ),

          Builder(
            builder: (context) {
              print('build go to homepage button');
              return TextButton(
                onPressed: () => context.goNamed('home'),
                child: Text('Go to Homepage'),
              );
            },
          ),

          Builder(
            builder: (context) {
              print('build show error button');
              return TextButton(
                onPressed: () => ErrorDialog.show('Something went wrong!'),
                child: Text('Show Error'),
              );
            },
          ),

          Builder(
            builder: (context) {
              print('build show loading button');
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
              print('build show info button');
              return TextButton(
                onPressed: () => InfoDialog.show('Archive only!'),
                child: Text('Show Info'),
              );
            },
          ),
          Builder(
            builder: (context) {
              print('build show success button');
              return TextButton(
                onPressed: () => SuccessDialog.show('Deleted correctly!'),
                child: Text('Show Success'),
              );
            },
          ),
          Builder(
            builder: (context) {
              print('build show prompt button');
              return TextButton(
                onPressed:
                    () => PromptDialog.show(
                      'Do you want to delete?',
                      onLeftClick: (cancel) {
                        cancel();
                      },
                      onRightClick: (cancel) {
                        cancel();
                      },
                    ),
                child: Text('Show Prompt'),
              );
            },
          ),

          TextButton(
            onPressed: () {
              // final authClient = context.readDependency<AuthApiClient>();
              // authClient.login();
              final authClient = context.readDependency<AuthApiClient>();
              authClient.login();
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
