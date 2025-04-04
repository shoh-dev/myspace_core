import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_ui/myspace_ui.dart';

import 'home_page.dart';
import 'home_page_vm.dart';

class HomePageLayout extends StatelessWidget {
  static final layout = UILayout(
    layoutBuilder: (context, state, shell) => HomePageLayout(shell: shell),
    pages: [
      [
        UIPage(
          name: 'home',
          path: "/home",
          vm: () => HomePageVm(),
          builder: (context, state, pageVm) {
            return HomePage(pageVm as HomePageVm);
          },
        ),
      ],
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
