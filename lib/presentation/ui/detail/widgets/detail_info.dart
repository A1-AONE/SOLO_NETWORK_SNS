import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({
    super.key,
    required this.contents,
    required this.imgUrl,
    required this.createdAt,
    required this.goods,
    required this.comment_count,
  });

  final String contents;
  final String imgUrl;
  final String createdAt;
  final int goods;
  final int comment_count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FeedNicknameBar(),
              imgUrl.isEmpty
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(imgUrl,
                              width: double.infinity, height: 250, fit: BoxFit.fill),
                        ),
                      ],
                    ),
              SizedBox(
                height: 16,
              ),
              Text(
                contents,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.8, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                createdAt,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.chat_bubble_rounded),
                  Text(' $comment_count'),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(Icons.favorite),
                  Text(' $goods'),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
