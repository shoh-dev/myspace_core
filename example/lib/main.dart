import 'package:example/core/store.dart';
import 'package:example/features/home/home_layout.dart';
import 'package:example/features/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runMySpaceApp(_appConfig);
}

final _appConfig = CoreAppConfig<AppStore>(
  appStore: AppStore(),
  root: UIRoot(layouts: [SplashPageLayout.layout, HomePageLayout.layout]),
);
