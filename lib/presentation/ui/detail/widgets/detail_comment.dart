import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailComment extends StatelessWidget {
  DetailComment({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          FeedNicknameBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '2025년 01월 03일',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey
                        ),
                      ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      // Text(
                      //   '댓글 쓰기',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     color: Colors.grey
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
