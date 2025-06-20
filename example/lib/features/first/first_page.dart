import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class FirstPage extends StatelessWidget {
  static final page = UIPage(
    name: 'first',
    path: "/first",
    builder: (context, state) => const FirstPage(),
  );

  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () => context.goNamed("splash"),
            child: Text("Go To Splash"),
          ),
        ],
      ),
    );
  }
}
