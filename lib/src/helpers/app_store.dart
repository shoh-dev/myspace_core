import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

extension AppStoreHelpers on BuildContext {
  T readAppStore<T extends CoreAppStore>() {
    return read<T>();
  }

  Future<void> addAppStoreEvent<E extends CoreAppStoreEvent>(E event) {
    final appStore = readAppStore<CoreAppStore<E, dynamic>>();
    return appStore.addEvent(event);
  }
}
