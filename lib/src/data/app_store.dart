import 'package:flutter/material.dart';

abstract class CoreAppStore extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter += 1;
    notifyListeners();
  }
}
