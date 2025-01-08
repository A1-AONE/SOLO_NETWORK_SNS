import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedCreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'create-feed',
      onPressed: () {
        context.go('/create');
      },
      backgroundColor: Colors.blue[300],
      child: Icon(Icons.add),
    );
  }
}
