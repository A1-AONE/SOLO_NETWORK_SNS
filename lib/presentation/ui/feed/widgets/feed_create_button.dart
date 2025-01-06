import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/ui/create_page/create_page.dart';

class FeedCreateButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePage(),
          ),
        );
      },
      backgroundColor: Colors.blue[300],
      child: Icon(Icons.add),
    );
  }
}