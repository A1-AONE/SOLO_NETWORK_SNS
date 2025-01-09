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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(user.profileUrl == ""
                      ? 'https://picsum.photos/40/40'
                      : user.profileUrl),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  widget.ai == "" ? user.nickName : aiInfo.firstWhere((ai)=> ai.ai == widget.ai).nickName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
          ],
        ),
      );
    }
  }
}
