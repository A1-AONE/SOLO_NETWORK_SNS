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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          FeedNicknameBar(),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              context.go('/feed/$feedId');
            },
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: Text(contenet,
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    imgUrl.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                imgUrl,
                                width: double.maxFinite,
                                height: 220,
                                fit: BoxFit.fill,
                              ),
                            ),
                        ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.chat_bubble_rounded),
                          Text(' $goods'),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite),
                          Text(' 1'),
                        ],
                      ),
                      Spacer(),
                      Text(
                        createdAt,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
