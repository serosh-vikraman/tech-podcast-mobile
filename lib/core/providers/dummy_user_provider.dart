import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dummy_user_provider.g.dart';

@Riverpod(keepAlive: true)
class DummyUser extends _$DummyUser {
  @override
  bool build() {
    return false;
  }

  void login() {
    state = true;
  }

  void logout() {
    state = false;
  }
}
