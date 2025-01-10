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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 8, left: 24, right: 24, top: 24),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      //프로필이미지
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
                    //닉네임
                    Text(
                      viewModel.nickName ?? '사용자 이름',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('로그아웃'),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),

                    //선택된 AI성격
                    Text('선택된 AI성격'),
                    Wrap(
                      spacing: 8.0, // 태그 간의 가로 간격
                      // runSpacing: 2.0, // 태그 간의 세로 간격
                      children: viewModel.aiTag.map((tag) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Chip(
                            label: Text(tag),
                            avatar: Icon(Icons.tag),
                            side: BorderSide.none,
                            onDeleted: () {
                              if (viewModel.aiTag.length <= 1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("최소 하나의 태그는 남아있어야 합니다.")),
                                );
                              } else {
                                // 태그 삭제 후 화면에서만 반영
                                ref
                                    .read(myPageViewModelProvider.notifier)
                                    .removeTag(tag); // 서버 통신 없이 상태만 변경
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    //ai 성격선택
                    Column(
                      children: [
                        Text('AI 성격 선택'),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 8.0, // 태그 간의 가로 간격
                              runSpacing: 8.0, // 태그 간의 세로 간격
                              children: ref
                                  .read(myPageViewModelProvider.notifier)
                                  .aiAllTags
                                  .map((tag) => GestureDetector(
                                        onTap: () {
                                          if (!viewModel.aiTag.contains(tag)) {
                                            // 태그 추가
                                            ref
                                                .read(myPageViewModelProvider
                                                    .notifier)
                                                .state = viewModel.copyWith(
                                              aiTag: [...viewModel.aiTag, tag],
                                            );
                                          }
                                        },
                                        child: Chip(
                                          label: Text(tag),
                                          avatar: Icon(Icons.tag),
                                          side: BorderSide.none,
                                          backgroundColor:
                                              viewModel.aiTag.contains(tag)
                                                  ? Colors.blue[100]
                                                  : Colors.grey[0],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
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
                  // 수정하기
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
    );
  }
}
