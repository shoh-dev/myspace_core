import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/myspace_ui.dart';

import 'splash_page.dart';
import 'splash_page_vm.dart';

class SplashPageLayout extends StatelessWidget {
  static final layout = UILayout(
    layoutBuilder: (context, state, shell) => SplashPageLayout(shell: shell),
    pages: [
      [
        UIPage(
          name: 'splash',
          path: "/",
          vm: (context) => SplashPageVm(context: context),
          builder: (context, state, vm) {
            return SplashPage(vm as SplashPageVm);
          },
        ),
      ],
    ],
  );

  const SplashPageLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Splash Layout')), body: shell);
  }
}
