import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/detail/widgets/detail_comment.dart';
import 'package:solo_network_sns/presentation/detail/widgets/detail_info.dart';

class Detail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DetailInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text('2025년 01월 03일'),
          ),
          Divider(thickness: 1, color: Colors.black),
          DetailComment(),
        ],
      ),
    );
  }
}