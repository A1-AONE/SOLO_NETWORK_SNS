import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_comment_view_model.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class Feed extends ConsumerStatefulWidget {
  Feed({
    required this.feedId,
    required this.contenet,
    required this.createdAt,
    required this.goods,
    required this.imgUrl,
    required this.ai,
  });
  final String feedId;
  final String contenet;
  final String createdAt;
  final int goods;
  final String imgUrl;
  final String ai;

  @override
  ConsumerState<Feed> createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed> {
  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(detailCommentsViewModel);
    final selectedComment = comments!
        .where(
          (comment) => comment.feed_id == widget.feedId,
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          FeedNicknameBar(widget.ai),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              context.go('/feed/${widget.feedId}');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.contenet,
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  widget.imgUrl.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              widget.imgUrl,
                              width: double.maxFinite,
                              height: 220,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.chat_bubble_rounded),
                            Text(' ${selectedComment.length}'),
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite),
                            Text(' ${widget.goods}'),
                          ],
                        ),
                        Spacer(),
                        Text(
                          widget.createdAt,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
