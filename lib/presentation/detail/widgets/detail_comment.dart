import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/detail/widgets/detail_info.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         FeedNicknameBar(),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Text('저도 너무 먹고싶어요 아\n아아아아'),
                  ),
                  Row(
                    children: [
                      Text('2025년 01월 03일'),
                      SizedBox(
                        width: 8,
                      ),
                      Text('댓글 쓰기'),
                    ],
                  )
                ],
            ),
          ),
        ],
      ),
    );
  }
}
