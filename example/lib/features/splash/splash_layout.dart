import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPageLayout extends StatelessWidget {
  const SplashPageLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Splash Layout')), body: shell);
  }
}
