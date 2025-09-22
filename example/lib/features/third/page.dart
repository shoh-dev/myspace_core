import 'package:example/features/third/auth_service.dart';
import 'package:example/features/third/vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            return VmSelector<ThirdPageVm, Creds?>(
              selector: (context, vm) => vm.creds,
              builder: (context, creds, _) {
                if (creds != null) {
                  return Text("Third Page - ${creds.name}");
                }
                return const Text("Third Page - Not Authenticated");
              },
            );
          },
        ),
      ),
      body: VmWatcher<ThirdPageVm>(
        builder: (context, vm, _) {
          final result = vm.authStatus;

          if (vm.creds != null) {
            return Center(
              child: ButtonComponent.primary(
                text: 'Logout',
                isLoading: result.isLoading,
                onPressed: vm.logout,
              ),
            );
          }
          return Center(
            child: ButtonComponent.primary(
              text: 'Login',
              isLoading: result.isLoading,
              onPressed: vm.login,
            ),
          );
        },
      ),
    );
  }
}
