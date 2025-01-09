import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<UserProfileEntity> getUserData(String uid);
}
