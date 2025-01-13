import 'package:solo_network_sns/domain/entitiy/user_entity.dart';
import 'package:solo_network_sns/domain/repository/user/user_repository.dart';

class UserUsecase {
  UserUsecase(this._userRepository);
  final UserRepository _userRepository;

  Future<List<UserEntity>?> fetchUserExecute() async{
    return await _userRepository.fetchUser();
  }

  Stream<List<UserEntity>?> streamUserExecute() {
    return _userRepository.streamUsers();
  }
}