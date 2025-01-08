import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page_view_model.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed_create_button.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final feeds = ref.watch(feedsViewModel);
          if (feeds!.isEmpty) {
            return const Center(child: Text('No feeds available.'));
          }
          return ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              final feed = feeds[index];
              return Feed(
                feedId: feed.id,
                contenet: feed.contents,
                imgUrl: feed.imageUrl,
                goods: feed.goods.toString(),
                createdAt: DateFormat("yyyy년 MM월 dd일").format(feed.createdAt),
              );
            },
          );
        },
      ),
      floatingActionButton: FeedCreateButton(),
    );
  }
}
