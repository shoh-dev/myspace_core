import 'dart:developer';

import 'package:example/core/store.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:example/features/third/auth_service.dart';
import 'package:example/features/third/auth_repository.dart';
import 'package:example/features/third/page.dart';
import 'package:example/features/third/vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class MyTheme extends AppTheme {
  @override
  ThemeData get darkTheme => ThemeData.dark();

  @override
  ThemeData get lightTheme => ThemeData.light();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = CoreAppConfig<AppStore>(
    appStore: AppStore(),
    theme: UITheme(
      themeMode: (context) => ThemeMode.light,
      theme: (context) => MyTheme(),
    ),
    root: UIRoot(
      defaultTransition: TransitionType.cupertino,
      layouts: [
        UIRoute<SplashPageVm>.page(
          path: "/",
          vm: (context, state) => SplashPageVm(),
          builder: (context, state) => const SplashPage(),
        ),
        UIRoute<ThirdPageVm>.page(
          path: "/third",
          vm: (context, state) => ThirdPageVm(context.read()),
          builder: (context, state) => const ThirdPage(),
        ),
      ],
    ),

    dependencies: [
      Provider<ApiClient>(create: (context) => ApiClient()),
      Provider<AuthApiClient>(
        create: (context) => AuthApiClient(context.read()),
      ),
      ChangeNotifierProvider<ThemeDep>(create: (context) => ThemeDep()),
      Provider<AuthService>(create: (context) => AuthService()),
      ChangeNotifierProvider<AuthRepository>(
        create: (context) => AuthRepository(context.read()),
      ),
    ],
  );
  runMySpaceApp(appConfig);
}

class ApiClient extends Dependency {
  void get(String path) {
    log("ApiClient get $path");
  }

  void post(String path) {
    log("ApiClient post $path");
  }
}

class AuthApiClient extends Dependency {
  final ApiClient _apiClient;

  const AuthApiClient(ApiClient apiClient) : _apiClient = apiClient;

  void login() {
    log('AuthApiClient login');
    _apiClient.get('/login');
  }
}

class ThemeDep extends DependencyChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleThemeMode() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}

class AppPlugin extends Dependency {
  void test() {
    log('Testing');
  }
}
