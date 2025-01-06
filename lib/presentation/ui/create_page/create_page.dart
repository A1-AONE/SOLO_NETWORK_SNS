import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create-feed',
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: 43,
                        width: 138,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '게시하기',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24), // Row와 TextFormField 간 간격 추가
                  TextFormField(
                    maxLines: 7, // 7줄로 설정
                    decoration: InputDecoration(
                      hintText: "내용을 입력하세요...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 24), // TextFormField와 아래 컨텐츠 간 간격 추가
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.tag),
                      Text('djfndj'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(
                        Icons.image_search,
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.tag),
                      Spacer(),
                      Icon(Icons.add_circle_outline),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
