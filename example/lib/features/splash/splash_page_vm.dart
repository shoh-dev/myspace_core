import 'package:myspace_core/myspace_core.dart';

class SplashPageVm extends Vm {
  SplashPageVm({required super.context});

  int counter1 = 0;

  void incrementCounter1() {
    counter1 += 1;
    notifyListeners();
  }
}
