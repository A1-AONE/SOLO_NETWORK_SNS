import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/my_page/view_model/my_page_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class MyPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  void initState() {
    super.initState();
    _initializeData(); // 초기 데이터 로딩
  }

  // 데이터 초기화 로직을 메서드로 분리
  void _initializeData() {
    final uid = ref.read(userViewModelProvider); // uid 가져오기
    ref
        .read(myPageViewModelProvider.notifier)
        .initializeUserData(uid); // 서버에서 데이터 새로 받기
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData(); // 페이지가 다시 로드될 때마다 호출
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(myPageViewModelProvider);

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
                      onDeleted: () async {
                        if (viewModel.aiTag.length <= 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("최소 하나의 태그는 남아있어야 합니다.")),
                          );
                        } else {
                          // 태그 삭제 후 화면에서만 반영
                          await ref
                              .read(myPageViewModelProvider.notifier)
                              .removeTag(tag); // 서버 통신 없이 상태만 변경
                        }
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
