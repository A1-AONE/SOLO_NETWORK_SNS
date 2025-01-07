import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/create_page/viewmodel/create_view_model.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class CreatePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createViewModelProvider.notifier);
    final state = ref.watch(createViewModelProvider);

    // UserViewModel을 사용하여 사용자 ID 가져오기
    final userId = ref.watch(userViewModelProvider);

    return Hero(
      tag: 'create-feed',
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          viewModel.clearFields();
                          context.go('/create/feed');
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          if (state.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage!)),
                            );
                            return;
                          }

                          await viewModel.postFeed(userId);
                          viewModel.clearFields();
                          context.go('/create/feed');
                        },
                        child: Text(
                          '게시하기',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // 내용 입력
                          TextField(
                            controller: state.contentEditingController,
                            minLines: 1,
                            maxLines: null,
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
                          if (state.selectedImage != null)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(
                                      File(state.selectedImage!.path)),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          if (state.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                state.errorMessage!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final isPersonDetected =
                                await viewModel.pickImage();
                            if (isPersonDetected) {
                              print('isPersonDetectedaaaaaaaaaaaaaaaaaa');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('사람이 포함된 사진은 업로드할 수 없습니다.')),
                              );
                            }
                          },
                          child: Icon(Icons.image_search),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.tag),
                        Expanded(
                          child: TextField(
                            controller: state.tagEditingController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: "태그를 입력하세요.",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: viewModel.addTag,
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
      ),
    );
  }
}
