import 'package:flutter/material.dart';

abstract class Vm extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter += 1;
    notifyListeners();
  }
}
