import 'package:myspace_core/myspace_core.dart';

class AuthService extends Dependency {
  Future<Creds> login() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Creds(email: 'test@example.com', name: 'Test User'),
    );
  }

  Future<void> logout() {
    return Future.delayed(const Duration(seconds: 1));
  }
}

class Creds {
  final String email;
  final String name;

  Creds({required this.email, required this.name});
}
