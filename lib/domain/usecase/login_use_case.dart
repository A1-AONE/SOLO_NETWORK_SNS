import 'package:firebase_auth/firebase_auth.dart';
import 'package:solo_network_sns/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);

  //
  Future<List<String>> execute() async {
    try {
      // google 계정으로 로그인
      final googleLogin = await loginRepository.signInWithGoogle();
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('$googleLogin');
      if (googleLogin == null) {
        throw Exception('Google 로그인 실패!');
      }

      // Firebase Auth 정보 생성
      final googleAuth = await googleLogin.authentication;
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('$googleAuth');
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('$credential');

      // 받은 Token 이용해서 google 계정으로 인증받은 사용자 정보 Firebase Auth에 등록
      final userCredential =
          await loginRepository.signInWithFirebase(credential);
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('$userCredential');
      final uid = userCredential.user?.uid;
      
      if (uid == null) {
        throw Exception('Firebase 인증 실패!');
      }

      final email = userCredential.user?.email;
      if (email == null) {
        throw Exception('Firebase 사용자 이메일 없음!');
      }

      // Database에서 기존 사용자 검색
      final userDocs = await loginRepository.fetchUserEmail(email);
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('$userDocs');

      // 기존 사용자 피드 페이지로 이동
      if (userDocs.docs.isNotEmpty) {
        print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
        print('isNotEmpty');
        return ['/', uid];
      }
      print('!!!!!!!!!호ㅏㄱ인용!!!!!!!!!');
      print('isEmpty');

      // 새로운 사용자는 Firestore에 데이터 저장 후 set페이지로 이동
      await loginRepository.saveNewUser(uid, email);
      return ['/login/set', uid];
    } catch (e) {
      print('!!!!!!!!!!!');
      print('LoginUseCase 예외!!!: $e');
      rethrow;
    }
  }
}
