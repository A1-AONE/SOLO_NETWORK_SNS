import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class SetpageFourWelcome extends StatelessWidget {
  const SetpageFourWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final setPageState = ref.watch(setPageViewModelProvider);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 40, height: 40, child: Image.asset('assets/logo/logo.png')),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(right: 48),
              child: Text('${setPageState.nickname} 님의 세상에', style: TextStyle(fontSize: 28),),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text('오신것을 환영합니다!', style: TextStyle(fontSize: 28),),
            ),
            SizedBox(height: 56,)
          ],
        );
      },
    );
  }
}
