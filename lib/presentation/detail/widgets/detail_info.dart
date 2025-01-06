import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class DetailInfo extends StatelessWidget{
  const DetailInfo({super.key});


  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('닉네임'),
                PopupMenuButton(itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
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
                ]),
                
              ],
          ),
          Image.network('https://picsum.photos/362/227', ),
          SizedBox(
            height: 8,
          ),
          Text(
            '스타게피 맛있어요 으ㅏ르ㅏㅇ으랑르ㅏ으ㅏㄹ으ㅏ르앙르ㅏ르ㅏㅡㅏㅡㅏㅡㅏ또 먹고싶어요',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}