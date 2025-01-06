import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('닉네임'),
            Text('01월 03일'),
            PopupMenuButton(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Text('Item 1'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: Text('Item 2'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemThree,
                  child: Text('Item 3'),
                ),
              ],
            ),
          ],
        ),
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
