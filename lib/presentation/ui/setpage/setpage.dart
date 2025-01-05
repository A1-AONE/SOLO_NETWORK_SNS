import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/main_window.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/next_elevated_button.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/progress_bar.dart';

class Setpage extends StatelessWidget {
  const Setpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final setPageState = ref.watch(setPageViewModelProvider);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                SizedBox(height: 24),
                // 진행바
                ProgressBar(setPageState: setPageState),
                SizedBox(height: 24),
                // 본문
                MainWindow(setPageState: setPageState),
                // 계속하기 버튼
                NextElevatedButton(),
                SizedBox(height: 40)
              ],
            )),
          ),
        );
      },
    );
  }
}
