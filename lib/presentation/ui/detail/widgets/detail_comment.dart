import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';

class DetailComment extends StatefulWidget {
  DetailComment(
      {required this.content, required this.createdAt, required this.ai});

  final String content;
  final String createdAt;
  final String ai;

  @override
  State<DetailComment> createState() => _DetailCommentState();
}

class _DetailCommentState extends State<DetailComment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
          child: FeedNicknameBar(widget.ai),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 50),
                child: Text(
                  widget.content,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat("yyyy년 MM월 dd일")
                        .format(DateTime.parse(widget.createdAt)),
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
