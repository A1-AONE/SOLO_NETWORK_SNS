import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
import 'package:solo_network_sns/presentation/widgets/nickname_bar/feed_nickname_bar_view_model.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class FeedNicknameBar extends ConsumerStatefulWidget {
  const FeedNicknameBar({super.key});


  @override
  ConsumerState<FeedNicknameBar> createState() => _FeedNicknameBarState();
}

class _FeedNicknameBarState extends ConsumerState<FeedNicknameBar> {
  @override
  void initState() {
    ref.read(userViewModel.notifier).fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userViewModel);
    final user = userInfo!
        .firstWhere((users) => users.uid == 'GBZKnPz6TOfR9cGTrhNCKVTPoNe2');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network('https://picsum.photos/40/40'),
              ),
              SizedBox(width: 8,),
              Text(
                // user.nickName,
                'nickname',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
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
