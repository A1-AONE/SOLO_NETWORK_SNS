import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:solo_network_sns/data/dto/user_profile_dto.dart';
import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  UserProfileRepositoryImpl({
    FirebaseFirestore? firestoreInstance,
    FirebaseStorage? storageInstance,
  })  : firestore = firestoreInstance ?? FirebaseFirestore.instance,
        storage = storageInstance ?? FirebaseStorage.instance;

  @override
  Future<UserProfileEntity> getUserData(String uid) async {
    try {
      // Firestore에서 특정 uid를 기준으로 사용자 데이터를 가져옴
      final DocumentSnapshot userDoc =
          await firestore.collection('User').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      // Firestore 데이터에서 JSON 형태로 변환
      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

      // DTO를 통해 Entity로 변환
      final userDto = UserProfileDto.fromJson(userData);
      return userDto.toEntity();
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  @override
  Future<void> saveUserData(UserProfileEntity userData,
      {File? imageFile}) async {
    try {
      String? imageUrl;
      print('${imageUrl}111111111111111111111111');
      // 1. 이미지 업로드
      if (imageFile != null) {
        final ref = storage.ref().child(
            'users/${userData.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = await ref.putFile(imageFile);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      // 2. DTO 변환
      final userDto = UserProfileDto.fromEntity(userData);

      // 3. Firestore 저장
      await firestore.collection('User').doc(userData.uid).set({
        ...userDto.toJson(),
        if (imageUrl != null) 'profileUrl': imageUrl, // 이미지 URL 업데이트
      });
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }
}
