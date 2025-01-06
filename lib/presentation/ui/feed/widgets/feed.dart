
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(color: Colors.black,),
          FeedNicknameBar(),
          GestureDetector(
            onTap: () {
              context.go('/feed');
            },
            child: Row(
              children: [
                SizedBox(width: 50,),
                Column(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Text(
                              '파스타 맛있어요',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network('https://picsum.photos/300/200'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.chat_bubble_rounded),
                              Text('1'),
                              SizedBox(width: 16,),
                              Icon(Icons.favorite),
                              Text('1'),
                            ],
                          ),
                          SizedBox(width: 70,),
                          Text('2025년 01월 03일', style: TextStyle(fontSize: 15, color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
