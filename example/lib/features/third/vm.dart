import 'package:example/features/third/auth_service.dart';
import 'package:example/features/third/auth_repository.dart';
import 'package:myspace_core/myspace_core.dart';

class ThirdPageVm extends Vm<EmptyVmEvent, EmptyVmState> {
  ThirdPageVm(this._authRepository) : super(const EmptyVmState());

  final AuthRepository _authRepository;

  @override
  Future<void> onEvent(EmptyVmEvent event, VmEmitter<EmptyVmState> emit) async {
    switch (event) {
      // Handle different event types here
    }
  }

  UIResult<void> _authStatus = UIResult.initial();
  UIResult<void> get authStatus => _authStatus;

  Creds? get creds => _authRepository.creds;

  void login() {
    _authStatus = UIResult.loading();
    notifyListeners();
    _authRepository.login().whenComplete(() {
      _authStatus = UIResult.ok(null);
      notifyListeners();
    });
  }

  void logout() {
    _authStatus = UIResult.loading();
    notifyListeners();
    _authRepository.logout().whenComplete(() {
      _authStatus = UIResult.ok(null);
      notifyListeners();
    });
  }
}
