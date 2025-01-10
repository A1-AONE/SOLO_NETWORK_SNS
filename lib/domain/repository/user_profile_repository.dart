import 'dart:io';

import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<void> saveUserData(UserProfileEntity userData, {File? imageFile});
  Future<UserProfileEntity> getUserData(String uid);
}
