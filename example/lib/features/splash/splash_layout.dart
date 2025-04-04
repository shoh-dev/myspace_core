import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
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
          vm: () => SplashPageVm(),
          builder: (context, state, pageVm) {
            return SplashPage(pageVm as SplashPageVm);
          },
        ),
      ],
    ],
  );

  const SplashPageLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Splash Layout'), actions: [
         
        ],
      ),
      body: shell,
    );
  }
}

class SplashLayoutVm extends Vm {}
