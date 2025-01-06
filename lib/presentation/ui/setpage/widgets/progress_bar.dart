import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, this.setPageState});

  final setPageState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
        ),
        setPageState.currentPage == 1
            ? Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                        onPressed: () {
                          ref.read(setPageViewModelProvider.notifier).beforePage();
                        }, icon: Icon(Icons.arrow_back_ios)),
                  );
                },
              )
            : SizedBox(width: 40, height: 40,),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            curve: Curves.linearToEaseOut,
            tween: Tween<double>(
              begin:
                  (setPageState.previousPage) / (setPageState.pages.length - 1),
              end: (setPageState.currentPage) / (setPageState.pages.length - 1),
            ),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value),
          ),
        ),
        SizedBox(
          width: 80,
        )
      ],
    );
  }
}
