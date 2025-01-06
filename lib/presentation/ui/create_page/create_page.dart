import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/create_page/viewmodel/create_view_model.dart';

class CreatePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createViewModelProvider.notifier);
    final state = ref.watch(createViewModelProvider);

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
                        Navigator.pop(context);
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
                      onPressed: () {},
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
                // 중간 부분분
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 내용 입력 TextField
                        TextField(
                          controller:
                              state.contentEditingController, // state를 통해 접근
                          minLines: 1,
                          maxLines: null, //줄 제한 없이 늘어남
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
                        if (state.selectedImage != null)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image:
                                    FileImage(File(state.selectedImage!.path)),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        else
                          Container(),

                        // 태그 출력
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: state.tags.map((tag) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Chip(
                                label: Text(tag),
                                avatar: Icon(Icons.tag),
                                side: BorderSide.none,
                                onDeleted: () => viewModel.removeTag(tag),
                              ),
                            );
                          }).toList(),
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
                        onTap: viewModel.pickImage, // 이미지 선택 함수 실행
                        child: Icon(Icons.image_search),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.tag),
                      Expanded(
                        child: TextField(
                          controller:
                              state.tagEditingController, // state를 통해 접근
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "태그를 입력하세요.",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
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
