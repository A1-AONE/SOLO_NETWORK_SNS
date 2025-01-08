import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeedNicknameBar(),
        Text('저도 너무 먹고싶어요 아\n아아아아'),
        Row(
          children: [
            Text(
              '2025년 01월 03일',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              '댓글쓰기',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
