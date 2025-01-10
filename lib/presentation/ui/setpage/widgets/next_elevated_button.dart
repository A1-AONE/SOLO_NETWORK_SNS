import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
                    if (setPageState.nickname == null ||
                        setPageState.nickname == '') {
                      break;
                    } else {
                      ref.read(setPageViewModelProvider.notifier).nextPage();
                    }
                    break;

                  case 1:
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('이렇게 설정하시겠습니까?'),
                          ),
                          backgroundColor: Colors.white,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'NickName : ${setPageState.nickname}\n',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '[ AI 친구 ]\n',
                                style: TextStyle(fontSize: 20),
                              ),
                              ...List.generate(setPageState.selectTags.length,
                                  (index) {
                                List<int> idx =
                                    setPageState.selectTags.toList();
                                return Text(
                                  '# ${setPageState.aiTags[idx[index]]}',
                                  style: TextStyle(fontSize: 16),
                                );
                              }),
                              setPageState.selectTags.isEmpty
                                  ? Text('# 무작위',
                                      style: TextStyle(fontSize: 16))
                                  : SizedBox.shrink(),
                            ],
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('취소')),
                                TextButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              setPageViewModelProvider.notifier)
                                          .nextPage();
                                      Navigator.pop(context);
                                    },
                                    child: Text('확인'))
                              ],
                            ),
                          ],
                        );
                      },
                    );
                    break;

                  case 2:
                    break;

                  case 3:
                    context.go('/');
                    break;
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 120, 120, 120)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                )),
              ),
              child: Text(
                setPageState.currentPage != 3 ? '계속하기' : '시작하기',
                style: TextStyle(
                    color: Colors.white, letterSpacing: 2, fontSize: 16),
              )),
        ),
      );
    });
  }
}
