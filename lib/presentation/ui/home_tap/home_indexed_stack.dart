import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/home_view_model.dart';

class HomeIndexedStack extends StatelessWidget {
  const HomeIndexedStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        return IndexedStack(
          index: currentIndex,
          children: [
            FeedPage(),
          ],
        );
      },
    );
  }
}