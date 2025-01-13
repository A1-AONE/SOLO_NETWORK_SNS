import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/create_page/view_model/create_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class CreatePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  late bool isUpload;

  @override
  void initState() {
    isUpload = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createViewModelProvider.notifier);
    final state = ref.watch(createViewModelProvider);

    // UserViewModel을 사용하여 사용자 ID 가져오기
    final userId = ref.watch(userViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        viewModel.clearFields(); // 상태 초기화
                      },
                      child: Text(
                        '지우기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        if (!isUpload &&
                            (state.contentEditingController.text.isNotEmpty ||
                                state.contentEditingController.text != '')) {
                          isUpload = true;
                          await viewModel.postFeed(userId); // DB 저장
                          viewModel.clearFields(); // 상태 초기화
                          context.go('/'); // 게시 후 이전 화면으로 이동
                        } else {
                          return;
                        }
                      },
                      child: Text(
                        '게시하기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24), // Row와 TextField 간 간격 추가
                // 중간 부분
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 내용 입력 TextField
                        TextField(
                          controller:
                              state.contentEditingController, // state를 통해 접근
                          minLines: 1,
                          maxLines: null, // 줄 제한 없이 늘어남
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "내용을 입력하세요.",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: 24),

                        // 이미지 미리보기
                        if (state.notPerson && state.selectedImage != null)
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: FileImage(
                                  File(state.selectedImage!.path),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        else if (!state.notPerson &&
                            state.selectedImage != null)
                          Column(
                            children: [
                              Text(
                                '사람 이미지가 감지되었습니다.',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '사람 이미지는 등록할 수 없습니다.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        else
                          Container(
                            child: Text(
                              '사람 이미지는 등록할 수 없습니다.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        SizedBox(
                          height: 8,
                        ),
                        // 태그 출력
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: state.tags.map((tag) {
                              return Chip(
                                label: Text(tag),
                                avatar: Icon(Icons.tag),
                                side: BorderSide.none,
                                onDeleted: () => viewModel.removeTag(tag),
                              );
                            }).toList(),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),

                // 하단 고정 영역
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await viewModel
                              .pickImage(context); // BuildContext를 전달
                        }, // 이미지 피커 함수 실행
                        child: Icon(Icons.image_search),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.tag),
                      Expanded(
                        child: TextField(
                          controller: state.tagEditingController,
                          maxLines: 1,
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: "태그를 입력하세요.",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: viewModel.addTag, // 태그 추가 함수 실행
                        child: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
