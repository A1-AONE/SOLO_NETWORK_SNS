import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/detail/widgets/comment.dart';

class DetailComment extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Comment(),
        Comment(),
        Comment(),
      ],
    );
  }
}