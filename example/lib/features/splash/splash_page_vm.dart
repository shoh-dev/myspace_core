import 'package:example/core/store.dart';
import 'package:myspace_core/myspace_core.dart';

class SplashPageVm extends Vm {
  SplashPageVm();

  int counter1 = 0;

  void incrementCounter1() {
    counter1 += 1;
    notifyListeners();
  }

  // int get storeCounter => context.watchAppStore<AppStore>().counter;
}
