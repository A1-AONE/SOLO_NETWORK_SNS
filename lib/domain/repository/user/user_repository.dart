import 'package:solo_network_sns/domain/entitiy/user_entity.dart';

abstract interface class UserRepository {
  Future<List<UserEntity>?> fetchUser();
  Stream<List<UserEntity>?> streamUsers();
}
