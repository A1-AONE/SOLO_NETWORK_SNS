import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed.dart';
import 'package:solo_network_sns/presentation/ui/feed/widgets/feed_create_button.dart';

class FeedPage extends StatelessWidget{
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Feed(),
          Feed(),
          Feed(),
        ],
      ),
      floatingActionButton: FeedCreateButton(),
    );
  }
}
