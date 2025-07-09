import 'package:myspace_core/myspace_core.dart';

class AppStore extends CoreAppStore<CoreAppStoreEvent, AppStoreState> {
  AppStore() : super(AppStoreState());

  @override
  Future<void> onEvent(
    CoreAppStoreEvent event,
    AppStoreEmitter<AppStoreState> emit,
  ) {
    throw UnimplementedError();
  }
}

class AppStoreState {}
