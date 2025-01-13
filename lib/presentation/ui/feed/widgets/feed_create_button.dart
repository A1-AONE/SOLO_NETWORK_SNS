import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedCreateButton extends StatelessWidget {
  const FeedCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/create');
      },
      backgroundColor: Colors.grey[500],
      child: Icon(Icons.add, color: Colors.white,),
    );
  }
}
