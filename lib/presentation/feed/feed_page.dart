import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/feed/widgets/feed.dart';

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
    );
  }
}
