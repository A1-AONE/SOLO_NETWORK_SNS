import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/my_page/view_model/my_page_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // UserViewModel을 사용하여 사용자 ID 가져오기
    final uid = ref.watch(userViewModelProvider);

    // MyPageViewModel 초기화
    final viewModel = ref.watch(myPageViewModelProvider);

    // MyPageViewModel Notifier를 가져와 사용자 데이터를 초기화
    ref.read(myPageViewModelProvider.notifier).initializeUserData(uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: SingleChildScrollView(
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
                        //태그 삭제 로직
                        ref
                            .read(myPageViewModelProvider.notifier)
                            .removeTag(tag);
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
