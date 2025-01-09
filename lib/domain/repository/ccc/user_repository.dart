import 'package:solo_network_sns/domain/entitiy/ccc/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserData(String uid);
}
