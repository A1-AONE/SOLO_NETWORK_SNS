import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/my_page/view_model/my_page_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userViewModelProvider); // 사용자 ID 가져오기
    final viewModel = ref.watch(myPageViewModelProvider);

    // 데이터 초기화를 한 번만 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myPageViewModelProvider.notifier).initializeUserData(uid);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 24),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[200],
                      backgroundImage: viewModel.profileImage == null
                          ? (viewModel.profileUrl != null &&
                                  viewModel.profileUrl!.isNotEmpty
                              ? NetworkImage(viewModel.profileUrl!)
                              : null)
                          : FileImage(viewModel.profileImage!),
                      child: viewModel.profileImage == null &&
                              (viewModel.profileUrl == null ||
                                  viewModel.profileUrl!.isEmpty)
                          ? Icon(Icons.person, size: 60)
                          : null,
                    ),
                    GestureDetector(
                      onTap: () => ref
                          .read(myPageViewModelProvider.notifier)
                          .pickImage(),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(Icons.camera_alt,
                            size: 20, color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                viewModel.nickName ?? '사용자 이름',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: viewModel.aiTag.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Chip(
                      label: Text(tag),
                      avatar: Icon(Icons.tag),
                      side: BorderSide.none,
                      onDeleted: () {
                        ref
                            .read(myPageViewModelProvider.notifier)
                            .removeTag(tag);
                      },
                    ),
                  );
                }).toList(),
              ),
              Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      print(viewModel.profileImage);
                      print(viewModel.profileUrl);
                      ref
                          .read(myPageViewModelProvider.notifier)
                          .cancelUserData(uid); // 취소 함수 호출

                      context.go('/');
                      print(viewModel.profileImage);
                      print(viewModel.profileUrl);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      // 저장하기
                      await ref
                          .read(myPageViewModelProvider.notifier)
                          .saveUserData(uid);
                      context.go('/'); // 게시 후 이전 화면으로 이동
                    },
                    child: Text(
                      '수정하기',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
