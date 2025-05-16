import 'package:flutter/material.dart';

abstract class CoreAppStore extends ChangeNotifier {
  int counter = 0; //example

  void increment() {
    //example
    counter += 1;
    notifyListeners();
  }
}
