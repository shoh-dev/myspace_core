import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageLayout extends StatelessWidget {
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
