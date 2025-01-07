import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인 로딩 상태관리!

class LoginViewModel extends StateNotifier<bool> {
  LoginViewModel() : super(false);

  void startLoading() => state = true;
  void stopLoading() => state = false;
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, bool>((ref) {
  return LoginViewModel();
});
