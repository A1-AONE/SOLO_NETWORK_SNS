import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택 함수gi
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${_profileImage}111111111111111111111111');

    return Scaffold(
      // 뒤로가기 아이콘(leading)은 AppBar에 자동으로 생깁니다.
      appBar: AppBar(
        title: Text('마이페이지'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 페이지 이동
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // 프로필 이미지와 편집 버튼
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[200],
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                          ) // 이미지가 없을 때는 기본 아이콘을 표시
                        : null, // 이미지가 있으면 child를 null로 설정

                    backgroundImage: _profileImage == null
                        ? null // 이미지가 없으면 배경 이미지 없음
                        : FileImage(_profileImage!), // 이미지가 있으면 해당 이미지 사용
                  ),
                  GestureDetector(
                    onTap: _pickImage,
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
            // 사용자 이름
            Text(
              '사용자 이름',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20), Divider()
          ],
        ),
      ),
    );
  }
}
