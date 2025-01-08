import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/viewmodel/setpage_view_model.dart';

class SetpageTwoAiType extends StatelessWidget {
  const SetpageTwoAiType({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final setPageState = ref.watch(setPageViewModelProvider);

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '원하는 ',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'AI 친구',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text('를 알려주세요!', style: TextStyle(fontSize: 24))
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: Scrollbar(
                  thumbVisibility: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: List.generate(
                          (setPageState.aiTags.length / 2).round(), (index) {
                        return Row(
                          children: [
                            aiTagBox(setPageState, index * 2),
                            if ((index * 2) + 1 < setPageState.aiTags.length)
                              aiTagBox(setPageState, (index * 2) + 1),
                          ],
                        );
                      }),
                    ),
                  ),
                ))
              ],
            ));
      },
    );
  }

  Widget aiTagBox(var setPageState, int index) {
    return Consumer(
      builder: (context, ref, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ref.read(setPageViewModelProvider.notifier).selectCilck(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: setPageState.selectTags.contains(index) ? Colors.grey[300] : Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    '# ${setPageState.aiTags[index]}  ',
                    style: TextStyle(fontSize: 16),
                  )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
