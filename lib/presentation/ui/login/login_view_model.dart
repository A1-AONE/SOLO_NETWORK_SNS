import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/usecase/login_use_case.dart';
import 'package:solo_network_sns/presentation/providers.dart';

// 로그인 로딩 상태관리!

class LoginViewModel extends StateNotifier<String> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super('');

  void startLoading() => state = 'loading';
  void stopLoading() => state = '';

  Future<void> login() async {
    try {
      startLoading();
      final route = await _loginUseCase.execute(); // UseCase 호출
      // 로그인 성공 후 route 따라 페이지 이동
      state = route;
      
    } catch (e) {
      state = 'error';
      print('!!!!!!!!!!!!');
      print('로그인 과정에서 에러!!!: $e');
    } finally {
      stopLoading();
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, String>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginViewModel(loginUseCase);
});
