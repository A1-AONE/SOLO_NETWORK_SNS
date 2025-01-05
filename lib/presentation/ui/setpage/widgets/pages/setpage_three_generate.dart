import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class SetpageThreeGenerate extends ConsumerStatefulWidget {
  const SetpageThreeGenerate({super.key});

  @override
  ConsumerState<SetpageThreeGenerate> createState() =>
      _SetpageThreeGenerateState();
}

class _SetpageThreeGenerateState extends ConsumerState<SetpageThreeGenerate> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      ref.read(setPageViewModelProvider.notifier).nextPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 40,
      ),
      SizedBox(
        width: 50,
        height: 50,
        child: Image.asset('assets/logo/logo.png'),
      ),
      SizedBox(
        height: 40,
      ),
      Text('당신의 AI 세상을 생성중입니다...')
    ]);
  }
}
