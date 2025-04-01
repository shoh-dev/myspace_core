import 'dart:developer';

import 'package:example/core/store.dart';
import 'package:example/features/home/home_layout.dart';
import 'package:example/features/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = CoreAppConfig<AppStore>(
    appStore: AppStore(),
    root:
        (store) => UIRoot(
          refreshListenable: store,
          redirect: (context, state) {
            final counter = context.readAppStore<AppStore>().counter;
            // print(
            // "context.readAppStore() ${context.readAppStore<AppStore>().counter}",
            // );
            if (counter == 4) {
              return "/home";
            }
            return null;
          },
          layouts: [SplashPageLayout.layout, HomePageLayout.layout],
        ),
    dependencies: [
      Provider<ApiClient>(create: (context) => ApiClient()),
      Provider<AuthApiClient>(
        create: (context) => AuthApiClient(context.readDependency()),
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
