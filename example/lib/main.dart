import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

void main() {
  runMySpaceApp(_appConfig);
}

final _appConfig = CoreAppConfig(
  root: UIRoot(
    layouts: [
      UILayout(
        layoutBuilder:
            (context, state, shell) => _SplashPageLayout(shell: shell),
        pages: [
          [
            UIPage(
              name: 'splash',
              path: "/",
              vm: (context) => _SplashPageVm(),
              builder: (context, state, vm) {
                return _SplashPage(vm as _SplashPageVm);
              },
            ),
          ],
        ],
      ),
    ],
  ),
);

class _SplashPageLayout extends StatelessWidget {
  const _SplashPageLayout({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Splash Layout')), body: shell);
  }
}

class _SplashPageVm extends Vm {}

class _SplashPage extends StatelessWidget {
  const _SplashPage(this.vm);

  final _SplashPageVm vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Center(
          child: TextButton(
            onPressed: vm.increment,
            child: Text(vm.counter.toString()),
          ),
        );
      },
    );
  }
}
