import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailComment extends StatelessWidget {
  DetailComment({required this.content, required this.createdAt});

  final String content;
  final String createdAt;

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
                  Container(
                  constraints: BoxConstraints(
                    minHeight: 50
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("yyyy년 MM월 dd일")
                            .format(DateTime.parse(createdAt)),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                        ),
                      ),
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
