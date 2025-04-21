import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

import 'home_page.dart';
import 'home_page_vm.dart';

class HomePageLayout extends StatelessWidget {
  static final layout = UILayout(
    layoutBuilder: (context, state, shell) => HomePageLayout(shell: shell),
    branches: [
      UIBranch(
        pages: [
          UIPage(
            name: 'home',
            path: "/home",
            builder: (context, state) {
              return ChangeNotifierProvider(
                create: (context) => HomePageVm(),
                builder: (context, _) => HomePage(),
              );
            },
          ),
        ],
      ),
    ],
  );

  const HomePageLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage Layout')),
      body: shell,
    );
  }
}
