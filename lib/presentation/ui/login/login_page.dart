import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
          Container(
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 21,
                width: 21,
                decoration: BoxDecoration(color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(5)),
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
