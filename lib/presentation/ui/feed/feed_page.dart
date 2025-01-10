import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page_view_model.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed_create_button.dart';
import 'package:intl/intl.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final user_id = ref.read(userViewModelProvider.notifier).getUserId();

    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final feeds = ref.watch(feedsViewModel);

            final userFeedBefore =
                feeds?.where((feed) => feed.UID == user_id).toList();

            if (userFeedBefore!.isEmpty) {
              return const Center(child: Text('No feeds available.'));
            }

            final userFeed = userFeedBefore..sort((a,b)=> b.createdAt.compareTo(a.createdAt));

            return Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userFeed.length,
                    itemBuilder: (context, index) {
                      final feed = userFeed[index];
                      return Feed(
                        feedId: feed.id,
                        contenet: feed.contents,
                        imgUrl: feed.imageUrl,
                        goods: feed.goods,
                        createdAt:
                            DateFormat("yyyy년 MM월 dd일").format(feed.createdAt),
                        ai: feed.AI,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FeedCreateButton(),
    );
  }
}
