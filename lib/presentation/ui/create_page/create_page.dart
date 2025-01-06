import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  TextEditingController textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // 갤러리에서 이미지 선택
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image; // 선택된 이미지를 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              // 스크롤 가능한 영역
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              height: 43,
                              width: 138,
                              decoration: BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '게시하기',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24), // Row와 TextField 간 간격 추가
                        TextField(
                          controller: textEditingController,
                          minLines: 1, // 최소 줄 수 (1줄)
                          maxLines: null, // 최대 줄 수를 제한하지 않음
                          keyboardType: TextInputType.multiline, // 다중 줄 입력 가능
                          decoration: InputDecoration(
                            hintText: "내용을 입력하세요...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 24), // TextField와 아래 컨텐츠 간 간격 추가

                        // 이미지 미리보기
                        if (_selectedImage != null)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 200, // 이미지 높이
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(File(_selectedImage!.path)),
                                fit: BoxFit.contain, // 이미지 크기
                              ),
                            ),
                          )
                        else
                          Container(), //선택된 이미지가 없을 시

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.tag),
                            Text('djfndj'),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
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
                      onTap: _pickImage, // 이미지 선택 함수 실행
                      child: Icon(
                        Icons.image_search,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.tag),
                    Spacer(),
                    Icon(Icons.add_circle_outline),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
