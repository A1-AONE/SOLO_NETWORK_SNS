import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({
    super.key,
    required this.contents,
    required this.imgUrl,
    required this.createdAt,
    required this.goods,
    required this.commentcount,
    required this.ai,
  });

  final String contents;
  final String imgUrl;
  final String createdAt;
  final int goods;
  final int commentcount;
  final String ai;

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
              FeedNicknameBar(ai),
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
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.fill),
                        ),
                      ],
                    ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  contents,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.8, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_rounded),
                      Text(' $commentcount'),
                    ],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Row(
                    children: [
                      Icon(Icons.favorite),
                      Text(' $goods'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
