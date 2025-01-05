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

class _SetpageThreeGenerateState extends ConsumerState<SetpageThreeGenerate>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    Timer(Duration(seconds: 5), () {
      ref.read(setPageViewModelProvider.notifier).nextPage();
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('당신의 AI 세상을 생성중입니다 '),
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                double offset = (index * 0.3) % 1;
                double value = (animationController.value + offset) % 1;
                double translateY = value < 0.5
                    ? -10 * (1 - value * 2)
                    : -10 * (value * 2 - 1);

                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text('.'),
                  ),
                );
              },
            );
          })
        ],
      )
    ]);
  }
}
