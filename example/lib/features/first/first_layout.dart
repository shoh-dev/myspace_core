import 'package:example/features/first/first_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class FirstLayout extends StatelessWidget {
  static final layout = UILayout(
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
