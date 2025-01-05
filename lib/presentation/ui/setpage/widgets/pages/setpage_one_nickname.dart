import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class SetpageOneNickname extends ConsumerStatefulWidget {
  const SetpageOneNickname({super.key});

  @override
  ConsumerState<SetpageOneNickname> createState() => _SetpageOneNicknameState();
}

class _SetpageOneNicknameState extends ConsumerState<SetpageOneNickname> {
  late final textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.text = ref.read(setPageViewModelProvider).nickname;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              SizedBox(
                  width: 120,
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value) {
                      ref
                          .read(setPageViewModelProvider.notifier)
                          .setNickName(textEditingController.text);
                    },
                    maxLines: 1,
                    maxLength: 7,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: '닉네임 입력',
                        hintStyle: TextStyle(color: Colors.grey),
                        counterText: ''),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]')),
                    ],
                  )),
              Text(
                ' 님 반가워요!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(width: 48),
              Text(
                'A1',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text('이랑 세상을 만들러 가요!',
                  style: TextStyle(
                    fontSize: 24,
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/logo/logo.png')),
              SizedBox(
                width: 64,
              )
            ],
          )
        ],
      ),
    );
  }
}
