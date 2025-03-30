import 'package:example/core/store.dart';
import 'package:example/features/home/home_layout.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/home_page_vm.dart';
import 'package:example/features/splash/splash_layout.dart';
import 'package:example/features/splash/splash_page.dart';
import 'package:example/features/splash/splash_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runMySpaceApp(_appConfig);
}

final _appConfig = CoreAppConfig(
  appStore: AppStore(),
  root: UIRoot(
    layouts: [
      UILayout(
        layoutBuilder:
            (context, state, shell) => SplashPageLayout(shell: shell),
        pages: [
          [
            UIPage(
              name: 'splash',
              path: "/",
              vm: (context) => SplashPageVm(context: context),
              builder: (context, state, vm) {
                return SplashPage(vm as SplashPageVm);
              },
            ),
          ],
        ],
      ),
      UILayout(
        layoutBuilder: (context, state, shell) => HomePageLayout(shell: shell),
        pages: [
          [
            UIPage(
              name: 'homepage',
              path: "/home",

              vm: (context) => HomePageVm(context: context),
              builder: (context, state, vm) {
                return HomePage(vm as HomePageVm);
              },
            ),
          ],
        ],
      ),
    ],
  ),
);
