import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

Future<void> runMySpaceApp(CoreAppConfig config) async {
  runApp(
    UIApp(
      root: config.root,
    ),
  );
}

class CoreAppConfig {
  final UIRoot root;

  CoreAppConfig({required this.root});
}
