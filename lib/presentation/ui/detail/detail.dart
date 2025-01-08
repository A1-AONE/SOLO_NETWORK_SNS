import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:solo_network_sns/presentation/ui/detail/detail_info_view_model.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/comment.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_comment.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_comment_view_model.dart';
import 'package:solo_network_sns/presentation/ui/detail/widgets/detail_info.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';
import 'package:logger/logger.dart';

final logger = Logger(); // Logger 인스턴스 생성

class Detail extends ConsumerStatefulWidget {
  Detail({required this.feedId});

  final String feedId;

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

class _DetailState extends ConsumerState<Detail> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createViewModelProvider.notifier);
    final state = ref.watch(createViewModelProvider);
    final UserId = ref.watch(userViewModelProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer(
          builder: (context, ref, child) {
            final feedInfo = ref.watch(feedsViewModel);
            final selectedFeed = feedInfo?.firstWhere(
              (feed) => feed.id == widget.feedId,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DetailInfo(
                        contents: selectedFeed!.contents,
                        imgUrl: selectedFeed.imageUrl,
                        createdAt: DateFormat("yyyy년 MM월 dd일")
                            .format(selectedFeed.createdAt),
                        goods: selectedFeed.goods,
                      ),
                      Divider(thickness: 1, color: Colors.black),
                      Consumer(
                        builder: (context, ref, child) {
                          final comments = ref.watch(detailCommentsViewModel);
                          final selectedComment = comments
                              !.where(
                                (comment) => comment.feed_id == widget.feedId,
                              )
                              .toList();
                          return ListView.builder(
                            shrinkWrap: true, // ListView가 자식의 크기에 맞게 조정되도록
                            physics: NeverScrollableScrollPhysics(), // 스크롤 방지
                            itemCount: selectedComment.length,
                            itemBuilder: (context, index) {
                              
                              if (selectedComment.isNotEmpty) {
                                final commentInfo = selectedComment[index];
                                return DetailComment(content: commentInfo.comment,);
                              }
                              return Text('tttt');
                            },
                          );
                        },
                      ),
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
                          controller: state.contentEditingController,
                          decoration: InputDecoration(
                            hintText: '댓글을 입력하세요...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          await viewModel.postComment(UserId, selectedFeed.id);
                          viewModel.clearFields();
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
