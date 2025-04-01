import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class CoreAppStore extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter += 1;
    notifyListeners();
  }
}

extension AppStoreContextHelper on BuildContext {
  St readAppStore<St extends CoreAppStore>() => read<St>();
  St watchAppStore<St extends CoreAppStore>() => watch<St>();
}
