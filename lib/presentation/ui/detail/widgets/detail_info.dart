import 'package:flutter/material.dart';
import 'package:solo_network_sns/presentation/widgets/feed_nickname_bar.dart';


class DetailInfo extends StatelessWidget{
  const DetailInfo({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          FeedNicknameBar(),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network('https://picsum.photos/362/227'),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 150,
              child: Text(
                '스타게피 맛있어요 으ㅏ르ㅏㅇ으랑르ㅏ으ㅏㄹ으ㅏ르앙르ㅏ르ㅏㅡㅏㅡㅏㅡㅏ또 먹고싶어요',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}