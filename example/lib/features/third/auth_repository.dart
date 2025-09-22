import 'package:example/features/third/auth_service.dart';
import 'package:myspace_core/myspace_core.dart';

class AuthRepository extends DependencyChangeNotifier {
  final AuthService _authService;

  AuthRepository(this._authService);

  Creds? _creds;
  Creds? get creds => _creds;

  Future<void> login() async {
    _creds = await _authService.login();
    // can additional logic here
    // saving to secure storage, etc.
  }

  Future<void> logout() async {
    await _authService.logout();
    // can additional logic here
    // removing from secure storage, etc.
    _creds = null;
  }
}
