import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/login/login_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class LoginPage extends StatelessWidget {
  // void loginInWithGoogle(BuildContext context, WidgetRef ref) async {
  //   // 로딩 상태 확인
  //   final isLoading = ref.read(loginViewModelProvider);
  //   if (isLoading) return; // 중복 선택 방지

  //   ref.read(loginViewModelProvider.notifier).startLoading(); // 로딩 시작

  //   // =========================================

  //   try {
  //     // 스코프설정 - 내가 어떤 정보를 가지고 올지
  //     final GoogleSignIn googleSignIn = GoogleSignIn(
  //       scopes: ['email'],
  //     );

  //     // 구글 로그인
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     // 구글 로그인 결과에서 accessToken을 가져오기 위해
  //     // GoogleSignInAuthentication 가져오기
  //     final GoogleSignInAuthentication? googleSignInAuthentication =
  //         await googleSignInAccount?.authentication;

  //     if (googleSignInAuthentication == null) {
  //       return;
  //     }

  //     // ===================================== 1 end(구글 로그인)
  //     // ===================================== 2 start(파이어 베이스)

  //     // 이메일이 없는 상황 예외처리부분임. 사실 구글로그인이라 없어도 되는데, 혹시 구글 계정자체에 문제가 있어서
  //     // 로그인이 안될수도 있으니까! 넣어둠
  //     final String? email = googleSignInAccount?.email;
  //     if (email == null) {
  //       throw Exception('Google 로그인 실패!');
  //     }

  //     // Firestore에서 로그인한 이메일에 해당하는 기존 uid 검색
  //     final QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('User')
  //         .where('email', isEqualTo: email)
  //         .get();

  //     String uid;
  //     if (snapshot.docs.isNotEmpty) {
  //       uid = snapshot.docs.first.id; // 여기서 id는 문서ID임 uid(고유번호)랑 같은 값임

  //       // 닉네임 비어있으면 setpage로!
  //       final userDoc = snapshot.docs.first;
  //       final nickname = userDoc['Nickname'] as String? ?? '';

  //       ref.read(userViewModelProvider.notifier).setUserId(uid);

  //       if(nickname.isEmpty) {
  //         context.go('/login/set');
  //         return;
  //       } else {
  //         context.go('/');
  //       }

  //     } else {
  //       // 기존 uid가 없을때 새 uid 생성
  //       // Firebase Auth 에서 accessToken과 idToken으로 로그인 하기 위해 OAuthCredential 생성
  //       final OAuthCredential oauthCred = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(oauthCred);
  //       // print('uid: ${userCredential.user?.uid}');
  //       uid = userCredential.user?.uid ?? '';
  //     }

  //     // ===================================== 3 데이터 베이스에 사용자 uid저장

  //     // User 컬렉션에 데이터 저장

  //     final DocumentReference userDoc =
  //         FirebaseFirestore.instance.collection('User').doc(uid);

  //     // 기존 사용자 데이터 가져오기
  //     final DocumentSnapshot userSnapshot = await userDoc.get();

  //     if (!userSnapshot.exists) {
  //       // 새로운 사용자 - 데이터 저장
  //       final Map<String, dynamic> newData = {
  //         'AITag': [],
  //         'Nickname': '',
  //         'isCanSpying': false,
  //         'profileUrl': '',
  //         'uid': uid,
  //         'email': email,
  //       };

  //       await userDoc.set(newData);

  //       ref.read(userViewModelProvider.notifier).setUserId(uid);

  //       // 새로운 사용자 - set페이지로
  //       context.go('/login/set');
  //     } else {
  //       // 기존 사용자 - 마이 피드로
  //       context.go('/');
  //     }
  //   } catch (e) {
  //     log('!!!!!!!!!!!!');
  //     log('$e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('로그인 에러!'),
  //       ),
  //     );
  //   } finally {
  //     ref
  //         .read(loginViewModelProvider.notifier)
  //         .stopLoading(); // 예외 발생 여부 상관없이 항상 로딩 종료!
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Opacity(
                opacity: 0.8,
                child: Container(
                  width: 60,
                  height: 63,
                  child:
                      Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 75),
            ],
          ),
          SizedBox(height: 45),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '안녕하세요!\n우리는 ',
                  style: TextStyle(fontSize: 25, color: Color(0xFF747474)),
                ),
                TextSpan(
                  text: 'A1',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(0xFF474747),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '이에요\n\n',
                  style: TextStyle(fontSize: 25, color: Color(0xFF747474)),
                ),
                TextSpan(
                  text: '나만의 세상에 오신 걸\n환영해요!',
                  style: TextStyle(fontSize: 30, color: Color(0xFF747474)),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(loginViewModelProvider);
              

              return InkWell(
                // 중복 선택 방지
                onTap: isLoading == 'loading'
                    ? null // 로딩중에는 클릭 못함
                    : () async {
                        try {
                          var route = await ref
                              .read(loginViewModelProvider.notifier)
                              .login();
                          ref.read(userViewModelProvider.notifier).setUserId(route[1]);
                          if (route.isNotEmpty &&
                              isLoading != 'loading' &&
                              isLoading != 'error') {
                            // ignore: use_build_context_synchronously
                            // context.go(route);
                            context.go(route[0]);
                            
                          }

                          //
                        } catch (e) {
                          print('로그인 실패!: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('로그인 실패!'),
                            ),
                          );
                        }
                      },
                splashColor: Color(0xFFEBEBEB),
                splashFactory: InkRipple.splashFactory,
                radius: 300,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  height: 60,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        offset: Offset(0, 2), // 그림자 위치
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 26),
                      Container(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          'assets/images/google_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 59),
                      Text(
                        'Google로 시작하기',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 21,
                width: 21,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(Icons.check, size: 19, color: Color(0xFF1C1B1F)),
              ),
              SizedBox(width: 8),
              // flutter package easy_rich_text 사용!
              EasyRichText(
                '로그인을 클릭하면 동의 및 개인정보에 동의하는 것으로 간주됩\n니다.',
                defaultStyle: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8D8D8D),
                ),
                patternList: [
                  EasyRichTextPattern(
                    targetString: '동의 및 개인정보',
                    style: TextStyle(color: Color(0xFFD28BBA)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
