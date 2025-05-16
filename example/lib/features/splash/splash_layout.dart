import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

import 'splash_page.dart';
import 'splash_page_vm.dart';

class SplashPageLayout extends StatelessWidget {
  static final layout = UILayout(
    layoutBuilder: (context, state, shell) => SplashPageLayout(shell: shell),
    branches: [
      UIBranch(
        pages: [
          UIPage(
            name: 'splash',
            path: "/",
            builder: (context, state) {
              return ChangeNotifierProvider(
                create: (context) => SplashPageVm(),
                builder: (context, child) => const SplashPage(),
              );
            },
          ),
        ],
      ),
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
