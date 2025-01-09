import 'package:solo_network_sns/data/source/user_data_source.dart';
import 'package:solo_network_sns/domain/entitiy/user_entity.dart';
import 'package:solo_network_sns/domain/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource);
  final UserDataSource _userDataSource;

  @override
  Future<List<UserEntity>?> fetchUser() async {
    final result = await _userDataSource.fetchUser();
    final newResult = result
        .map((e) => UserEntity(
              nickName: e.nickName,
              profileUrl: e.profileUrl,
              uid: e.uid,
            ))
        .toList();
    return newResult;
  }
}
