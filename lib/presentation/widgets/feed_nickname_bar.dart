import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';
import 'package:solo_network_sns/presentation/widgets/nickname_bar/ai_nickname_view_model.dart';
import 'package:solo_network_sns/presentation/widgets/nickname_bar/feed_nickname_bar_view_model.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class FeedNicknameBar extends ConsumerStatefulWidget {
  const FeedNicknameBar(this.ai, {super.key});

  final ai;

  @override
  ConsumerState<FeedNicknameBar> createState() => _FeedNicknameBarState();
}

class _FeedNicknameBarState extends ConsumerState<FeedNicknameBar> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userViewModel);
    final aiInfo = ref.watch(aiNicknameViewModel);
    if (userInfo == null || aiInfo == null) {
      return CircularProgressIndicator();
    } else {
      final user = userInfo.firstWhere((users) =>
          users.uid == ref.read(userViewModelProvider.notifier).getUserId());

      return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 4),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: widget.ai == ""
                    ? user.profileUrl == ""
                        ? Image.asset('assets/images/default_img.jpg')
                        : Image.network(user.profileUrl)
                    : aiInfo
                                .firstWhere((ai) => ai.ai == widget.ai)
                                .profileUrl ==
                            ''
                        ? Image.asset('assets/images/default_img.jpg')
                        : Image.network(aiInfo
                            .firstWhere((ai) => ai.ai == widget.ai)
                            .profileUrl),
              ),
            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.ai == ""
                      ? user.nickName
                      : aiInfo.firstWhere((ai) => ai.ai == widget.ai).nickName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(widget.ai == "" ? '소유자' : ' AI', style: TextStyle(fontSize: 14),)
              ],
            ),
            Spacer(),
            /*
            PopupMenuButton(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Text('수정'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: Text('삭제'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemThree,
                  child: Text('Item 3'),
                ),
              ],
            ),
            */
          ],
        ),
      );
    }
  }
}
