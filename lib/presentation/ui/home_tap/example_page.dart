import 'package:flutter/material.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '염탐',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 24,
          ),
          Text('아직 준비중인 서비스 입니다'),
        ],
      ),
    ));
  }
}
