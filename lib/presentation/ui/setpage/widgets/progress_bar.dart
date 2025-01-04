import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, this.setPageState});

  final setPageState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(seconds: 1),
        curve: Curves.linearToEaseOut,
        tween: Tween<double>(
          begin: (setPageState.previousPage) / (setPageState.pages.length - 1),
          end: (setPageState.currentPage) / (setPageState.pages.length - 1),
        ),
        builder: (context, value, _) => LinearProgressIndicator(value: value),
      ),
    );
  }
}
