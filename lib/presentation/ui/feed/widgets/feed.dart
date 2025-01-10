import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class Feed extends ConsumerStatefulWidget {
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
  ConsumerState<Feed> createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed> {
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
              context.go('/feed/${widget.feedId}');
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
                            width: 300,
                            child: Text(widget.contenet,
                                style: TextStyle(fontSize: 20),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                          ),
                          widget.imgUrl.isEmpty
                              ? SizedBox(
                                  height: 50,
                                  width: 300,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.imgUrl,
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded),
                            Text(widget.goods),
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
                          widget.createdAt,
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
