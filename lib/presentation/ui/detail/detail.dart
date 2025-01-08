import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_comment.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_info.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page_view_model.dart';

class Detail extends StatelessWidget {
  Detail({
    required this.feedId,
  });

  final String feedId;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer(
          builder: (context, ref, child) {
            final feedInfo = ref.watch(feedsViewModel);
            final selectedFeed = feedInfo?.firstWhere(
              (feed) => feed.id == feedId,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DetailInfo(
                        contents: selectedFeed!.contents,
                        imgUrl: selectedFeed.imageUrl,
                        createdAt: DateFormat("yyyy년 MM월 dd일").format(selectedFeed.createdAt),
                        goods: selectedFeed.goods,
                      ),
                      Divider(thickness: 1, color: Colors.black),
                      // 댓글 리스트
                      DetailComment(),
                      DetailComment(),
                      DetailComment(),
                      DetailComment(),
                      DetailComment(),
                    ],
                  ),
                ),
                // 댓글 입력창
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: '댓글을 입력하세요...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // 댓글 전송 로직 추가 가능
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
