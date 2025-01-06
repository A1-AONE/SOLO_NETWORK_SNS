import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/detail/detail.dart';
import 'package:solo_network_sns/presentation/detail/widgets/detail_info.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('닉네임'),
            PopupMenuButton(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Text('Item 1'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: Text('Item 2'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemThree,
                  child: Text('Item 3'),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Detail()),);
    },
          child: Column(
            children: [
              Text('파스타 맛있어요'),
              Container(
                height: 300,
                width: 300,
                color: Colors.grey,
              ),
            ],
          ))
      ],
    );
  }
}
