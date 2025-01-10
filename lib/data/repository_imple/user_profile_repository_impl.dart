import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/data/dto/user_profile_dto.dart';
import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final FirebaseFirestore firestore;

  UserProfileRepositoryImpl({FirebaseFirestore? firestoreInstance})
      : firestore = firestoreInstance ?? FirebaseFirestore.instance;

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
  Future<void> saveUserData(UserProfileEntity userData) async {
    try {
      await firestore
          .collection('User')
          .doc(userData.uid)
          .update(userData.toJson());
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }
}
