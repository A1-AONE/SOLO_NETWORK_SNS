import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

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
                    backgroundImage: _profileImage == null
                        ? AssetImage('assets/default_avatar.png')
                            as ImageProvider
                        : FileImage(_profileImage!),
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
            // 팔로워 정보
            Text('팔로워 100명', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            // 기능 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.chat, '채팅', () {
                  // 채팅 페이지로 이동
                }),
                _buildIconButton(Icons.article, '게시물', () {
                  // 게시물 페이지로 이동
                }),
              ],
            ),
            SizedBox(height: 20),
            // 기능 버튼과 게시글 목록 사이의 구분선
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 10),
            // 게시글 목록 - 프로필 아이콘 제거
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('게시글 제목 $index'),
                  subtitle: Text('게시글 내용 미리보기...'),
                  onTap: () {
                    // 게시글 상세보기로 이동
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 아이콘 버튼 빌드 함수
  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.grey.shade700),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
