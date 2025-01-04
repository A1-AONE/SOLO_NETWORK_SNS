import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/progress_bar.dart';

class Setpage extends StatelessWidget {
  const Setpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final setPageState = ref.watch(setPageViewModelProvider);

        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              SizedBox(height: 40),
              // 진행바
              ProgressBar(setPageState: setPageState),
              // 본문
              setPageState.pages[setPageState.currentPage],
            ],
          )),
        );
      },
    );
  }
}
