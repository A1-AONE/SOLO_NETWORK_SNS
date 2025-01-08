import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class Feed extends StatelessWidget {
  Feed({
    required this.feedId,
    required this.contenet,
    required this.createdAt,
    required this.goods,
    required this.imgUrl,
  });
  final String feedId;
  final String contenet;
  final String createdAt;
  final String goods;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(
            color: Colors.black,
          ),
          FeedNicknameBar(),
          GestureDetector(
            onTap: () {
              context.go('/feed/$feedId');
            },
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Text(
                              contenet,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                           imgUrl.isEmpty
                              ? SizedBox(height: 50, width: 300,)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(imgUrl, width: 300, height: 200,fit: BoxFit.contain,),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded),
                            Text(goods),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(Icons.favorite),
                            Text('1'),
                          ],
                        ),
                        SizedBox(
                          width: 95,
                        ),
                        Text(
                          createdAt,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
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
