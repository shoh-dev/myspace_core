import 'package:example/features/first/first_layout_vm.dart';
import 'package:example/features/first/first_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FirstLayout extends StatelessWidget {
  static final layout = UILayout<FirstLayoutVm>(
    builder:
        (context, shell) => ChangeNotifierProvider(
          create: (context) => FirstLayoutVm(),
          child: FirstLayout(shell: shell),
        ),
    layoutBuilder: (context, state, shell) => FirstLayout(shell: shell),
    branches: [
      UIBranch(pages: [FirstPage.page]),
    ],
  );

  const FirstLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Layout'), actions: []),
      body: shell,
    );
  }
}
