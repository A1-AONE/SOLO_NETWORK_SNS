import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/detail/detail.dart';
import 'package:solo_network_sns/presentation/detail/widgets/detail_info.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(),
          FeedNicknameBar(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detail()),
              );
            },
            child: Column(
              children: [
                Text('파스타 맛있어요'),
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
