import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class NextElevatedButton extends StatelessWidget {
  const NextElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final setPageState = ref.watch(setPageViewModelProvider);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
              onPressed: () {
                switch (setPageState.currentPage) {
                  case 0:
                    if (setPageState.nickname == null || setPageState.nickname == '') {
                      return;
                    } else {
                      ref.read(setPageViewModelProvider.notifier).nextPage();
                    }
                    break;
                  case 1: break;
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF1F2631)),
              ),
              child: Text(
                '계속하기',
                style: TextStyle(color: Colors.white),
              )),
        ),
      );
    });
  }
}
